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
          <ul>
            <li
                v-for="user in users"
                :key="user.id"
            >
              {{user.name}}
              <v-btn
                  @click="addUserToChannel(user)"
              >
                追加する
              </v-btn>
            </li>
          </ul>
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
      users: []
    }
  },
  async created() {
    const res = await axios.get('/users')
    this.users = res.data
    // TODO: すでにチャンネルに入っているユーザは除外したい
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
    }
  }
}
</script>