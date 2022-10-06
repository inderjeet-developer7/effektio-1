import 'dart:async';

import 'package:effektio/controllers/chat_room_controller.dart';
import 'package:effektio_flutter_sdk/effektio_flutter_sdk_ffi.dart'
    show
        Client,
        Conversation,
        FfiListConversation,
        InvitationEvent,
        RoomMessage,
        TypingEvent;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

//Helper class.
class JoinedRoom {
  Conversation conversation;
  LatestMessage? latestMessage;

  JoinedRoom({
    required this.conversation,
    this.latestMessage,
  });
}

//Helper class.
class LatestMessage {
  String sender;
  String body;
  int originServerTs;

  LatestMessage({
    required this.sender,
    required this.body,
    required this.originServerTs,
  });
}

class ChatListController extends GetxController {
  Client client;
  late String userId;
  List<JoinedRoom> joinedRooms = [];
  List<InvitationEvent> invitationEvents = [];
  bool initialLoaded = false;
  String? currentRoomId;
  StreamSubscription<FfiListConversation>? convosSubscription;
  StreamSubscription<TypingEvent>? typingSubscription;
  StreamSubscription<RoomMessage>? messageSubscription;

  ChatListController({required this.client}) : super() {
    userId = client.userId().toString();
  }

  @override
  void onInit() {
    super.onInit();
    if (!client.isGuest()) {
      convosSubscription = client.conversationsRx().listen((event) {
        updateList(event.toList(), userId);
      });
      typingSubscription = client.typingEventRx()?.listen((event) {
        String roomId = event.roomId();
        List<String> userIds = [];
        for (final userId in event.userIds()) {
          userIds.add(userId.toDartString());
        }
        debugPrint('typing event ' + roomId + ': ' + userIds.join(', '));
      });
      messageSubscription = client.messageEventRx()?.listen((event) {
        if (currentRoomId != null) {
          ChatRoomController controller = Get.find<ChatRoomController>();
          if (event.sender() != userId) {
            controller.loadMessage(event);
          }
          update(['Chat']);
        }
      });
      client.getInvitedRooms().then((events) {
        invitationEvents = events.toList();
        client.invitationEventRx()?.listen((event) {
          debugPrint('invited event: ' + event.roomName());
          int index = invitationEvents.indexWhere((x) {
            return x.roomId() == event.roomId();
          });
          if (index == -1) {
            invitationEvents.insert(0, event);
          } else {
            invitationEvents.removeAt(index);
          }
          update(['Chat']);
        });
      });
    }
  }

  @override
  void onClose() {
    convosSubscription?.cancel();
    typingSubscription?.cancel();
    messageSubscription?.cancel();
    super.onClose();
  }

  void setCurrentRoomId(String? roomId) {
    currentRoomId = roomId;
  }

  void updateList(List<Conversation> convos, String userId) {
    if (!initialLoaded) {
      initialLoaded = true;
    }
    update(['chatlist']);
    List<JoinedRoom> newItems = [];
    for (Conversation convo in convos) {
      String roomId = convo.getRoomId();
      int oldIndex = joinedRooms.indexWhere((x) {
        return x.conversation.getRoomId() == roomId;
      });
      RoomMessage? msg = convo.latestMessage();
      if (msg == null) {
        // prevent latest message from deleting
        if (oldIndex == -1) {
          JoinedRoom newItem = JoinedRoom(conversation: convo);
          newItems.add(newItem);
        } else {
          JoinedRoom newItem = JoinedRoom(
            conversation: convo,
            latestMessage: joinedRooms[oldIndex].latestMessage,
          );
          newItems.add(newItem);
        }
        continue;
      }
      JoinedRoom newItem = JoinedRoom(
        conversation: convo,
        latestMessage: LatestMessage(
          sender: msg.sender(),
          body: msg.body(),
          originServerTs: msg.originServerTs(),
        ),
      );
      newItems.add(newItem);
    }
    joinedRooms = newItems;
    update(['chatlist']);
  }

  void moveItem(int from, int to) {
    JoinedRoom item = joinedRooms.removeAt(from);
    joinedRooms.insert(to, item);
    update(['chatlist']);
  }

  InvitationEvent? findInvitation(String roomId) {
    int index = invitationEvents.indexWhere((x) => x.roomId() == roomId);
    return index == -1 ? null : invitationEvents[index];
  }
}
