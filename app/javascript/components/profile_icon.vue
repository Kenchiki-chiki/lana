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
import axios from 'axios';
export default {
  data() {
    return {
      drawer: false
    }
  },
  methods: {
    logout() {
      console.log('====1====')
    
    this.$router.push({ path: 'http://localhost:3000/users/sign_out' }),
    this.$router.push({ path: 'http://localhost:3000/users/sign_up' })
  },
  
  
  }
}
</script>




<style>
  .account_icon {
  position: fixed;
  top: 10px;
  left: 10px;
}


</style>