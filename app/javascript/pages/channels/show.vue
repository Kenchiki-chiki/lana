<template>
  <v-app id="app">
    <profile/>
    <div class="sidebar">
      <h2>チャンネル詳細</h2>
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
    </div>
    
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
import Profile from '@/components/profile_icon.vue'
export default {
  components: {
    Profile
  },
  data() {
    return {
      dialog: false,
      channelName: null,
      errors: []
    }
  },
  props: {
    channels: {
      type: Array
    },
    channel: {
      type: Object
    }
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
    }
  }
}
</script>

<style scoped>
.sidebar {
  margin: 40px 0 0 30px;
}
</style>