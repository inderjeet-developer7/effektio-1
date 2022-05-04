#![warn(clippy::all)]

use anyhow::{bail, Context, Result};
use clap::Parser;

use effektio_core::events;
use effektio_core::matrix_sdk;
use effektio_core::ruma;

mod action;
mod config;

use crate::ruma::api::client::filter::RoomEventFilter;
use config::{Action, EffektioCliConfig};
use flexi_logger::Logger;
use log::{info, warn};

#[tokio::main]
async fn main() -> Result<()> {
    let cli = EffektioCliConfig::parse();
    Logger::try_with_str(cli.log)?.start()?;
    match cli.action {
        Action::PostNews(news) => news.run().await?,
        Action::FetchNews(config) => {
            let types = vec!["org.effektio.dev.news".to_owned()];
            let client = config.login.client().await?;
            // FIXME: is there a more efficient way? First sync can take very long...
            let sync_resp = client.sync_once(Default::default()).await?;
            let room = client
                .get_joined_room(&config.room)
                .context("Room not found or not joined")?;
            info!("Found room {:?}", room.name());
            let mut query = matrix_sdk::room::MessagesOptions::backward(&sync_resp.next_batch);
            let mut filter = RoomEventFilter::default();
            filter.types = Some(types.as_slice());
            query.filter = filter;
            let messages = room.messages(query).await?;
            if messages.chunk.is_empty() {
                bail!("no messages found");
            }
            for entry in messages.chunk {
                let event = match entry
                    .event
                    .deserialize_as::<ruma::events::MessageEvent<events::NewsEventDevContent>>()
                {
                    Ok(e) => e,
                    Err(e) => {
                        warn!("Non Compliant News Entry found: {}", e);
                        continue;
                    }
                };
                let news = event.content;
                let mut table = term_table::Table::new();
                table.add_row(term_table::row::Row::new(vec![
                    term_table::table_cell::TableCell::new_with_alignment(
                        event.event_id,
                        2,
                        term_table::table_cell::Alignment::Center,
                    ),
                ]));
                table.add_row(term_table::row::Row::new(vec![
                    term_table::table_cell::TableCell::new_with_alignment(
                        event.room_id,
                        1,
                        term_table::table_cell::Alignment::Center,
                    ),
                    term_table::table_cell::TableCell::new_with_alignment(
                        event.sender,
                        1,
                        term_table::table_cell::Alignment::Center,
                    ),
                ]));
                for content in news.contents {
                    let (key, content) = match content {
                        events::NewsContentType::Image(image) => (
                            "image",
                            image.url.map(|a| a.to_string()).unwrap_or(image.body),
                        ),
                        events::NewsContentType::Video(video) => (
                            "video",
                            video.url.map(|a| a.to_string()).unwrap_or(video.body),
                        ),
                        events::NewsContentType::Text(text) => ("text", text.body),
                        _ => ("unknown", "n/a".to_owned()),
                    };
                    table.add_row(term_table::row::Row::new(vec![
                        term_table::table_cell::TableCell::new_with_alignment(
                            key,
                            1,
                            term_table::table_cell::Alignment::Left,
                        ),
                        term_table::table_cell::TableCell::new_with_alignment(
                            content,
                            1,
                            term_table::table_cell::Alignment::Left,
                        ),
                    ]));
                }
                println!("{}", table.render());
            }
        }
        _ => unimplemented!(),
    }
    Ok(())
}
