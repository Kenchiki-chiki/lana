import Vue from "vue"
import Vuetify from "vuetify"
import "vuetify/dist/vuetify.min.css"
import HomeIndex from '@/pages/home/index.vue'

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
    const element = document.querySelector('#app')
    const title = element.dataset.title
    new Vue({
        vuetify,
        el: '#app',
        render: h => h(HomeIndex, {
            props: {
                title: title
            }
        })
    });
});