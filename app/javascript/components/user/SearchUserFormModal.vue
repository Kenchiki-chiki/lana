<template>
  <div>
    <v-dialog
        v-model="open"
        persistent
        max-width="600px"
    >
      <v-card>
        <v-card-title>
          ユーザをチャンネルに追加する
        </v-card-title>
        <v-card-text>
          <v-text-field
              v-model="name"
              :counter="10"
              label="ユーザ名で検索"
              @input="searchUsers"
          ></v-text-field>
          <div v-if="users.length > 0">
            <ul>
              <li
                  class="mt-5"
                  v-for="user in users"
                  :key="user.id"
              >
                {{user.name}}
                <v-btn
                    small
                    color="primary"
                    class="ml-3"
                    @click="addUserToChannel(user)"
                >
                  追加する
                </v-btn>
              </li>
            </ul>
          </div>
          <div v-else>
            <p>ユーザは見つかりませんでした</p>
          </div>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
              color="blue darken-1"
              text
              @click="toggleOpen"
          >
            閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    open: {
      type: Boolean
    },
    channel: {
      type: Object
    },
    toggleOpen: {
      type: Function,
      required: true,
      default: () => {}
    }
  },
  data() {
    return {
      users: [],
      name: ''
    }
  },
  async created() {
    const res = await axios.get('/users', { params: { channel_id: this.channel.id}})
    this.users = res.data
  },
  methods: {
    async addUserToChannel(user) {
      const endpoint = `/channels/${this.channel.id}/participations`
      const res = await axios.post(endpoint, { participation: { user_id: user.id }})
      if (res.data.errors.length > 0) {
        alert(res.data.errors)
      } else {
        location.reload()
        alert(`${user.name}さんをチャンネルに追加しました`)
      }
    },
    async searchUsers() {
      const res = await axios.get('/users', { params: { channel_id: this.channel.id, name: this.name}})
      this.users = res.data
    }
  }
}
</script>