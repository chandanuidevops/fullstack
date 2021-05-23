<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
                    <p class="_title0">
                        Roles
                        <button class="_btn" type="primary" @click="addModal = true">
                            <Icon type="md-add" />Add
                        </button>
                    </p>

                    <div class="_overflow _table_div">
                        <table class="_table">
                            <!-- TABLE TITLE -->
                            <tr>
                                <th>ID</th>
                                <th>Role Type</th>
                                <th>Created At</th>
                                <th>Action</th>
                            </tr>
                            <!-- TABLE TITLE -->

                            <!-- ITEMS -->
                            <tr v-for="(role,i) in roles" :key="i" v-if="roles.length">
                                <td>{{role.id}}</td>
                                <td class="_table_name">
                                   {{role.roleName}}
                                </td>
                                <td>{{role.created_at}}</td>
                                <td>
                                    <button
                                        class="_btn _action_btn edit_btn1"
                                        type="button" @click="showModal(role,i)"

                                    >
                                        Edit
                                    </button>
                                    <button
                                        class="_btn _action_btn make_btn1"
                                        type="button"
                                        @click="showDeletingModal(role,i)"
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
		<Modal v-model="addModal" title="Add Role Name" 
			:mask-closable="false"
			:closable="false"
		>
 			<Input v-model="data.roleName" placeholder="Enter Role Name" style="width: 300px" />
			<div slot="footer">
				<button class="_btn" type="default" @click="addModal=false">close</button>
				<button class="_btn" type="primary" @click="addRole" :disabled="isAdding">{{isAdding?'Adding...':'Add Role'}}</button>
			</div>					
		</Modal>
        <Modal v-model="editModal" title="Edit Role Name" 
			:mask-closable="false"
			:closable="false"
		>
 			<Input v-model="editData.roleName" placeholder="Enter Role Name" style="width: 300px" />
			<div slot="footer">
				<button class="_btn" type="default" @click="editModal=false">close</button>
				<button class="_btn" type="primary" @click="editRole" :disabled="isAdding">{{isAdding?'Updating...':'Update Role'}}</button>
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
 				RoleName: "",
			},
            editData:{
 				RoleName: "",
			},
			addModal: false,
			editModal: false,
			isAdding:false,
			roles:[],
            index:-1,
            showDeleteModal:false,
            i:-1,
            deleteItem:{},
            isDeleting:false
        };
    },
	methods:{
		async addRole(){
				const res =  await this.callApi("post", "/app/create_role", this.data);
				if (res.status === 201) {
					this.roles.unshift(res.data)
                    this.data.roleName='';
					this.addModal=false;
					this.success('Role has added  successfully')
				} else {
                    if(res.status==422){
                       this.error(res.data.errors.roleName[0])
                    }else{
                        this.swr()
                    }
				}
			},
        async editRole(){
				const res =  await this.callApi("post", "/app/update_role", this.editData);
				if (res.status === 200) {
                   
                    this.roles[this.index].roleName=this.editData.roleName
					this.editModal=false;
					this.success('Role has updated  successfully')
				} else {
                    if(res.status==422){
                       this.error(res.data.errors.roleName[0])
                    }else{
                        this.swr()
                    }
				}
			},
            showModal(role,index){
                let obj ={
                    id:role.id,
                    roleName:role.roleName,
                }
                this.editModal=true;
                this.editData=obj;
                this.index=index;
            },
            showDeletingModal(role,i){
                 const deleteModalObj={
                    showDeleteModal: true,
                    deleteUrl:'app/delete_role',
                    data:role,
                    isDeleted:false,
                    deletingIndex:i
                }
                this.showDeleteModal=true
                this.$store.commit('setDeletingModalObj',deleteModalObj)
            }
	},
    async created() {
        const res = await this.callApi("get", "/app/get_roles");
        if (res.status == 200) {
            this.roles=res.data;
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
                this.roles.splice(obj.deletingIndex,1)
            }
        }
     }
};
</script>
