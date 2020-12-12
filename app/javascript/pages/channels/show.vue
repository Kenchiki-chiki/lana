<template>
  <div>
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
    </v-navigation-drawer>
  </div>
</template>

<script>
export default {
  props: {
    channels: {
      type: Array
    },
    channel: {
      type: Object
    }
  }
}
</script>