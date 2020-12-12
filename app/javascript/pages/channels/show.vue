<template>
  <v-app id="app">
    <v-navigation-drawer
        app
        clipped
    >
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
    <v-main>
      <v-container>
        <profile/>
        <h2>{{ channel.name }}</h2>
        <v-icon
            large
            color="blue darken-2"
            @click="toggleOpen"
        >
          mdi-account-multiple-plus-outline
        </v-icon>
        <ul>
          <li
              v-for="message in messages"
              :key="message.id"
          >
            {{ message.user_name }}：{{ message.content }}
          </li>
        </ul>
        <v-form>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                    v-model="content"
                    :append-outer-icon="content ? 'mdi-send' : 'mdi-microphone'"
                    filled
                    clear-icon="mdi-close-circle"
                    clearable
                    label="Message"
                    type="text"
                    @click:append-outer="sendMessage"
                    @click:clear="clearMessage"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
      </v-container>
    </v-main>
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
    <SearchUserFormModal
        v-if="open"
        :open="open"
        :channel="channel"
        :toggle-open="toggleOpen"
        @onHide="toggleOpen"
    />
  </v-app>
</template>

<script>
import axios from 'axios'
import SearchUserFormModal from '@/components/user/SearchUserFormModal'
import Profile from '@/components/profile_icon.vue'

export default {
  components: {
    SearchUserFormModal,
    Profile
  },
  data() {
    return {
      dialog: false,
      channelName: null,
      content: null,
      errors: [],
      messageErrors: [],
      open: false
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
  methods: {
    toggleOpen() {
      this.open = !this.open
    },
    openModal() {
      this.dialog = true
    },
    async createChannel() {
      const endpoint = '/channels'
      const res = await axios.post(endpoint, { channel: { name: this.channelName }})
      if (res.data.errors.length > 0) {
        this.errors = res.data.errors
      } else {
        this.dialog = false
        location.reload()
      }
    },
    async sendMessage () {
      this.clearMessage()
      const endpoint = `/channels/${this.channel.id}/messages`
      const res = await axios.post(endpoint, { message: { content: this.content }})
      if (res.data.errors.length > 0) {
        this.messageErrors = res.data.errors
      } else {
        location.reload()
      }
    },
    clearMessage () {
      this.message = ''
    },
  }
}
</script>

<style scoped>
.sidebar {
  margin: 40px 0 0 30px;
}
</style>