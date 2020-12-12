import Vue from "vue"
import Vuetify from "vuetify"
import "vuetify/dist/vuetify.min.css"
import ChannelsShow from '@/pages/channels/show.vue'

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
    const element = document.querySelector('#app')
    const channels = JSON.parse(element.dataset.channels)
    const channel = JSON.parse(element.dataset.channel)
    const messages = JSON.parse(element.dataset.messages)
    new Vue({
        vuetify,
        el: '#app',
        render: h => h(ChannelsShow, {
            props: {
                channels: channels,
                channel: channel,
                messages: messages
            }
        })
    });
});