import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import homeComponent from './components/pages/HomePage'
//admin components
import TagsComponent from './admin/pages/TagsComponent'
import CategoryComponent from './admin/pages/CategoryComponent'
import AdminuserComponent from './admin/pages/Adminuser'
import Role from './admin/pages/Role'
import AssignRole from './admin/pages/AssignRole'
import CreateBlog from './admin/pages/CreateBlog'
import EditBlog from './admin/pages/EditBlog'
import Blogs from './admin/pages/Blogs'
import NotFound from './admin/pages/NotFound'
import login from './admin/pages/Login'
import usecomp from './vuex/usecomp'
const routes = [
    {
        path:'/',
        component:homeComponent,
        name:'home'
    },
    {
        path:'/tags',
        component:TagsComponent,
        name:'tags'
    },
    {
        path:'/category',
        component:CategoryComponent,
        name:'category'
    },
    {
        path:'/role',
        component:Role,
        name:'role'
    },
    {
        path:'/assignRole',
        component:AssignRole,
        name:'assignRole'
    },
    {
        path:'/adminusers',
        component:AdminuserComponent,
        name:'adminusers'
    },
    {
        path:'/createBlog',
        component:CreateBlog,
        name:'createBlog'
    },
    {
        path:'/editBlog/:id',
        component:EditBlog,
        name:'editBlog'
    },
    {
        path:'/blogs',
        component:Blogs,
        name:'blogs'
    },
    {
        path:'*',
        component:NotFound,
        name:'notfound'
    },
    {
        path:'/login',
        component:login,
        name:'login'
    },
    {
        path:'/vuex',
        component:usecomp,
        name:'vuex'
    },
];

export default new VueRouter({
    mode: 'history',
    hash: false,
    routes,
})