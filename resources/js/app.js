require('./bootstrap');

// window.Vue = require('vue');
import Vue from 'vue'
import router from './router';
import ViewUI from 'view-design';
import common from './common'
import jsonToHtml from './jsonToHtml'
import store from './store'
import 'view-design/dist/styles/iview.css';
import Editor from 'vue-editor-js';
Vue.use(Editor)
Vue.use(ViewUI);
Vue.mixin(common); 
Vue.mixin(jsonToHtml); 
Vue.component('app-component', require('./components/AppComponent.vue').default);
import App from './components/AppComponent'
const app = new Vue({
    el: '#app',
    router:router,
    components:{
        'app-component':App,
    },
    store,
});
 

