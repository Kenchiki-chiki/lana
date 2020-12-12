<template>
    <v-app class="account_icon">
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
    </v-app>
</template>




<script>
export default {
  methods: {
    async logout() {
      await axios().delete('http://localhost:3000/users/sign_out')
    this.$router.push({ path: 'http://localhost:3000/users/sign_up' })
  },
  
  }
}
</script>




<style>
  .account_icon {
  position: fixed;
  top: 20px;
  left: 20px;
}


</style>