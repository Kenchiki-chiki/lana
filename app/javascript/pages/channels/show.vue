<template>
  <v-app id="app">
    <v-navigation-drawer>
      <v-list>
        <v-list-item-group v-for="list_channel in channels" :key="list_channel.id">
          <a :href="`/channels/${list_channel.id}`">
            <v-list-item>
              <v-list-item-title>
                {{ list_channel.name }}
              </v-list-item-title>
            </v-list-item>
          </a>
        </v-list-item-group>
      </v-list>
      <v-btn
          class="mx-2"
          fab
          dark
          color="indigo"
          @click="openModal"
      >
        <v-icon dark>
          mdi-plus
        </v-icon>
      </v-btn>
    </v-navigation-drawer>
    <v-content>
      <v-container>
        <ul>
          <li
              v-for="message in messages"
              :key="message.id"
          >
            {{ message }}
          </li>
        </ul>
        <v-form>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                    v-model="message"
                    :append-outer-icon="message ? 'mdi-send' : 'mdi-microphone'"
                    :prepend-icon="icon"
                    filled
                    clear-icon="mdi-close-circle"
                    clearable
                    label="Message"
                    type="text"
                    @click:append="toggleMarker"
                    @click:append-outer="sendMessage"
                    @click:prepend="changeIcon"
                    @click:clear="clearMessage"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </v-container>
    </v-content>
    <v-dialog
        v-model="dialog"
        persistent
        max-width="600px"
    >
      <v-card>
        <v-card-title class="headline grey lighten-2">
          チャンネルを新規登録する
        </v-card-title>
        <v-card-text>
          <div v-if="errors.length > 0">
            <v-alert
                class="mt-4"
                v-for="error in errors"
                :key="error"
                color="red"
                dark
            >
              {{ error }}
            </v-alert>
          </div>
          <v-text-field
              v-model="channelName"
              label="チャンネル名"
              required
          ></v-text-field>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
              color="blue darken-1"
              text
              @click="dialog = false"
          >
            閉じる
          </v-btn>
          <v-btn
              color="primary"
              text
              @click="createChannel"
          >
            登録する
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-app>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      dialog: false,
      channelName: null,
      message: null,
      iconIndex: 0,
      icons: [
        'mdi-emoticon',
        'mdi-emoticon-cool',
        'mdi-emoticon-dead',
        'mdi-emoticon-excited',
        'mdi-emoticon-happy',
        'mdi-emoticon-neutral',
        'mdi-emoticon-sad',
        'mdi-emoticon-tongue',
      ],
      errors: []
    }
  },
  props: {
    channels: {
      type: Array
    },
    channel: {
      type: Object
    },
    messages: {
      type: Array
    }
  },
  computed: {
    icon () {
      return this.icons[this.iconIndex]
    },
  },
  methods: {
    openModal() {
      this.dialog = true
    },
    async createChannel() {
      const endpoint = '/channels'
      const res = await axios.post(endpoint, { channel: { name: this.channelName }})
      if (res.data.errors.length > 0) {
        console.log(res.data.errors)
        this.errors = res.data.errors
      } else {
        this.dialog = false
        location.reload()
      }
    },
    sendMessage () {
      this.resetIcon()
      this.clearMessage()
    },
    clearMessage () {
      this.message = ''
    },
    resetIcon () {
      this.iconIndex = 0
    },
  }
}
</script>