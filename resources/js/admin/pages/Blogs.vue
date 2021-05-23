<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
                    <p class="_title0">
                        BLogs
                        <button class="_btn" type="primary" @click="$router.push('/createBlog')">
                            <Icon type="md-add" />Add BLog
                        </button>
                    </p>

                    <div class="_overflow _table_div" v-if="isReadPermitted">
                        <table class="_table">
                            <!-- TABLE TITLE -->
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Categories</th>
                                <th>Tags</th>
                                <th>Views</th>
                                <th>Created At</th>
                                <th>Action</th>
                            </tr>
                            <!-- TABLE TITLE -->

                            <!-- ITEMS -->
                            <tr v-for="(blog,i) in blogs" :key="i" v-if="blogs.length">
                                <td>{{blog.id}}</td>
                                 <td >{{blog.title}}</td>
                                <td >
                                   <span v-for="(c,j) in blog.cat" :key="j" v-if="blog.cat.length"> <Tag color="geekblue"> {{c.categoryName}}</Tag>
                                      
                                   </span>
                                </td>
                                 <td >
                                   <span v-for="(t,j) in blog.tag" :key="j" v-if="blog.tag.length">
                                       <Tag color="default">{{t.tagName}}</Tag>
                                   </span>
                                </td>
                                 <td >
                                   {{blog.views}}
                                </td>
                                <td>{{blog.created_at}}</td>
                                <td>
                                     <button
                                        class="_btn _action_btn edit_btn1"
                                        type="button"
                                    >
                                        Visit blog
                                    </button>
                                    <button
                                        class="_btn _action_btn edit_btn1"
                                        type="button" @click="$router.push(`/editBlog/${blog.id}`)"
                                        v-if="isUpdatePermitted"
                                    >
                                        Edit
                                    </button>
                                    <button
                                        class="_btn _action_btn make_btn1"
                                        type="button"
                                        @click="showDeletingModal(blog,i)"
                                         v-if="isdeletePermitted"
                                    >
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            <!-- ITEMS -->
                            
                        </table>
                        <Page :total="pageInfo.total" :page-size="parseInt(pageInfo.per_page)" :current="pageInfo.urrent_page" @on-change="getBlogData" v-if="pageInfo" />
                    </div>
                </div>
				
            </div>
        </div>
        <!-- delete alert modal -->
        <delete-modal></delete-modal>
        
    </div>
</template>
<script>
import deleteModal from '../common/DeleteComponent'
import {mapGetters} from 'vuex'
export default {
    data() {
        return {
			blogs:[],
            index:-1,
            showDeleteModal:false,
            i:-1,
            deleteItem:{},
            isDeleting:false,
            total:1,
            pageInfo:null,
        };
    },
	methods:{
            showDeletingModal(blog,i){
                 const deleteModalObj={
                    showDeleteModal: true,
                    deleteUrl:'app/delete_blog',
                    data:{id:blog.id},
                    isDeleted:false,
                    deletingIndex:i
                }
                this.showDeleteModal=true
                this.$store.commit('setDeletingModalObj',deleteModalObj)
            },
            async getBlogData(page =1){
               
                   const res = await this.callApi("get", `/app/blogData?page=${page}&total=${this.total}`);
                if (res.status == 200) {
                    this.blogs=res.data.data;
                    this.pageInfo=res.data;
                } else {
                this.swr()
                }
            }
	},
    async created() {
        this.getBlogData();
    },
     components:{
        deleteModal
    },
     computed:{
        ...mapGetters(['getDeletedModalObj'])
     },
     watch:{
        getDeletedModalObj(obj){
            if(obj.isDeleted){
                this.blogs.splice(obj.deletingIndex,1)
            }
        }
     }
};
</script>
