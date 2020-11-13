import CableReady from 'cable_ready'
import consumer from "./consumer"

consumer.subscriptions.create("FeedChannel", {
  connected() {
    console.log('Test')
  },

  received(data) {
    if (data.cableReady) CableReady.perform(data.operations)
  }
});