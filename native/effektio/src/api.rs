use anyhow::Result;
use futures::Stream;
use lazy_static::lazy_static;
use tokio::runtime;

use crate::platform;

lazy_static! {
    pub static ref RUNTIME: runtime::Runtime =
        runtime::Runtime::new().expect("Can't start Tokio runtime");
}

mod account;
mod auth;
mod client;
mod conversation;
mod device;
mod group;
mod invitation;
mod message;
mod news;
mod profile;
mod receipt;
mod room;
mod stream;
mod typing;
mod verification;

pub use account::Account;
pub use auth::{
    guest_client, login_new_client, login_with_token, register_with_registration_token,
};
pub use client::{Client, ClientStateBuilder, SyncState};
pub use conversation::{Conversation, CreateConversationSettingsBuilder};
pub use device::{DeviceChangedEvent, DeviceLeftEvent, DeviceRecord};
pub use effektio_core::models::{Color, Faq, News, Tag};
pub use group::{CreateGroupSettings, CreateGroupSettingsBuilder, Group};
pub use invitation::Invitation;
pub use message::{FileDescription, ImageDescription, RoomMessage};
pub use profile::{RoomProfile, UserProfile};
pub use receipt::{ReceiptEvent, ReceiptRecord};
pub use room::{Member, Room};
pub use stream::TimelineStream;
pub use typing::TypingEvent;
pub use verification::{VerificationEmoji, VerificationEvent};

#[cfg(feature = "with-mocks")]
pub use effektio_core::mocks::*;

pub type DeviceId = effektio_core::ruma::OwnedDeviceId;
pub type EventId = effektio_core::ruma::OwnedEventId;
pub type RoomId = effektio_core::ruma::OwnedRoomId;
pub type UserId = effektio_core::ruma::OwnedUserId;

#[cfg(all(not(doctest), feature = "dart"))]
ffi_gen_macro::ffi_gen!("native/effektio/api.rsh");

#[cfg(not(all(not(doctest), feature = "dart")))]
#[allow(clippy::module_inception)]
mod api {
    /// helpers for doctests, as ffigen for some reason can't find the path
    pub struct FfiBuffer<T>(Vec<T>);
    impl<T> FfiBuffer<T> {
        pub fn new(inner: Vec<T>) -> FfiBuffer<T> {
            FfiBuffer(inner)
        }
    }
}

fn init_logging(filter: Option<String>) -> Result<()> {
    platform::init_logging(filter)?;
    Ok(())
}
