<template>
    <div class="account_icon">
      <v-icon @click="drawer = true" color="indigo">
        mdi-account-circle
      </v-icon>
      <v-menu
        v-model="drawer"
      >
        <v-list
          class="list_position"
          nav
          dense
        >
          <v-list-item-group>
            <v-list-item>
              <v-list-item-title
               class="text--darken-3 mb-1"
               @click="logout"
              >
              ログアウト
              </v-list-item-title>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-menu>
    </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      drawer: false
    }
  },
  methods: {
    async logout() {
      const res = await axios.delete('/users/sign_out')
      if (res.status == 204) {
        location.reload()
        alert('ログアウトしました')
      } else {
        alert('ログアウトに失敗しました')
      }
    }
  }
}
</script>