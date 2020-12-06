<template>
  <div>
    <v-btn>Vuetifyのボタン</v-btn>
    <h2>{{ title }}</h2>
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String
    }
  }
}
</script>