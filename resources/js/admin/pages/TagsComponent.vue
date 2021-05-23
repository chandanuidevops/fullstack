<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
                    <p class="_title0">
                        Tags
                        <button class="_btn" type="primary" @click="addModal = true" v-if="isWritePermitted">
                            <Icon type="md-add" />Add
                        </button>
                    </p>

                    <div class="_overflow _table_div" v-if="isReadPermitted">
                        <table class="_table">
                            <!-- TABLE TITLE -->
                            <tr>
                                <th>ID</th>
                                <th>Tag Name</th>
                                <th>Created At</th>
                                <th>Action</th>
                            </tr>
                            <!-- TABLE TITLE -->

                            <!-- ITEMS -->
                            <tr v-for="(tag,i) in tags" :key="i" v-if="tags.length">
                                <td>{{tag.id}}</td>
                                <td class="_table_name">
                                   {{tag.tagName}}
                                </td>
                                <td>{{tag.created_at}}</td>
                                <td>
                                    <button
                                        class="_btn _action_btn edit_btn1"
                                        type="button" @click="showModal(tag,i)"
                                        v-if="isUpdatePermitted"
                                    >
                                        Edit
                                    </button>
                                    <button
                                        class="_btn _action_btn make_btn1"
                                        type="button"
                                        @click="showDeletingModal(tag,i)"
                                         v-if="isdeletePermitted"
                                    >
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            <!-- ITEMS -->
                        </table>
                    </div>
                </div>
				
            </div>
        </div>
		<Modal v-model="addModal" title="Add Tag Name" 
			:mask-closable="false"
			:closable="false"
		>
 			<Input v-model="data.tagName" placeholder="Enter Tag Name" style="width: 300px" />
			<div slot="footer">
				<button class="_btn" type="default" @click="addModal=false">close</button>
				<button class="_btn" type="primary" @click="addTag" :disabled="isAdding">{{isAdding?'Adding...':'Add Tag'}}</button>
			</div>					
		</Modal>
        <Modal v-model="editModal" title="Edit Tag Name" 
			:mask-closable="false"
			:closable="false"
		>
 			<Input v-model="editData.tagName" placeholder="Enter Tag Name" style="width: 300px" />
			<div slot="footer">
				<button class="_btn" type="default" @click="editModal=false">close</button>
				<button class="_btn" type="primary" @click="editTag" :disabled="isAdding">{{isAdding?'Updating...':'Update Tag'}}</button>
			</div>					
		</Modal>
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
			data:{
 				tagName: "",
			},
            editData:{
 				tagName: "",
			},
			addModal: false,
			editModal: false,
			isAdding:false,
			tags:[],
            index:-1,
            showDeleteModal:false,
            i:-1,
            deleteItem:{},
            isDeleting:false
        };
    },
	methods:{
		async addTag(){
				const res =  await this.callApi("post", "/app/create_tag", this.data);
				if (res.status === 201) {
					this.tags.unshift(res.data)
                    this.data.tagName='';
					this.addModal=false;
					this.success('Tag has added  successfully')
				} else {
                    if(res.status==422){
                       this.error(res.data.errors.tagName[0])
                    }else{
                        this.swr()
                    }
				}
			},
        async editTag(){
				const res =  await this.callApi("post", "/app/update_tag", this.editData);
				if (res.status === 200) {
                   
                    this.tags[this.index].tagName=this.editData.tagName
					this.editModal=false;
					this.success('Tag has updated  successfully')
				} else {
                    if(res.status==422){
                       this.error(res.data.errors.tagName[0])
                    }else{
                        this.swr()
                    }
				}
			},
            showModal(tag,index){
                let obj ={
                    id:tag.id,
                    tagName:tag.tagName,
                }
                this.editModal=true;
                this.editData=obj;
                this.index=index;
            },
            showDeletingModal(tag,i){
                 const deleteModalObj={
                    showDeleteModal: true,
                    deleteUrl:'app/delete_tag',
                    data:tag,
                    isDeleted:false,
                    deletingIndex:i
                }
                this.showDeleteModal=true
                this.$store.commit('setDeletingModalObj',deleteModalObj)
            }
	},
    async created() {
        const res = await this.callApi("get", "/app/get_tags");
        if (res.status == 200) {
            this.tags=res.data;
        } else {
           this.swr()
        }
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
                this.tags.splice(obj.deletingIndex,1)
            }
        }
     }
};
</script>
