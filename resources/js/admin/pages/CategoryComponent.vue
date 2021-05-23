<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20"
                >
                    <p class="_title0">
                        Categories
                        <button
                            class="_btn"
                            type="primary"
                            @click="addModal = true"
                        >
                            <Icon type="md-add" />Add
                        </button>
                    </p>

                    <div class="_overflow _table_div">
                        <table class="_table">
                            <!-- TABLE TITLE -->
                            <tr>
                                <th>ID</th>
                                <th>Category Name</th>
                                <th>Category Icon</th>
                                <th>Created At</th>
                                <th>Action</th>
                            </tr>
                            <!-- TABLE TITLE -->

                            <!-- ITEMS -->
                            <tr
                                v-for="(category, i) in categories"
                                :key="i"
                                v-if="categories.length"
                            >
                                <td>{{ category.id }}</td>
                                <td class="_table_name">
                                    {{ category.categoryName }}
                                </td>
                                 <td> <img :src="`${category.iconImage}`" alt="" style="height:50px;width:auto;"> </td>
                                <td>{{ category.created_at }}</td>
                               
                                <td>
                                    <button
                                        class="_btn _action_btn edit_btn1"
                                        type="button"
                                        @click="showEditModal(category, i)"
                                    >
                                        Edit
                                    </button>
                                    <button
                                        class="_btn _action_btn make_btn1"
                                        type="button"
                                        @click="showDeletingModal(category, i)"
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
        <Modal
            v-model="addModal"
            title="Add Tag Name"
            :mask-closable="false"
            :closable="false"
            >
            <Input
                v-model="data.categoryName"
                placeholder="Enter Category Name"
                style="width: 100%"
            />
            <div class="space"></div>
             <Upload
                ref="uploads"
                type="drag"
                action="app/upload_category"
                :headers = "{'x-csrf-token':token,'X-Requested-With':'XMLHttpRequest'}"
                :on-success="handleSuccess"
                :format="['jpg','jpeg','png']"
                :on-error="handleError"
                :max-size="2048"
                :on-format-error="handleFormatError"
                :on-exceeded-size="handleMaxSize"
            >
                <div style="padding: 20px 0">
                    <Icon
                        type="ios-cloud-upload"
                        size="52"
                        style="color: #3399ff"
                    ></Icon>
                    <p>Click or drag files here to upload</p>
                </div>
            </Upload>
            <div class="demo-upload-list" v-if="data.iconImage" >
                <template >
                    <img :src="`/uploads/${data.iconImage}`">
                    <div class="demo-upload-list-cover">
                        <Icon type="ios-trash-outline" @click="handleRemove(data.iconImage)"></Icon>
                    </div>
                </template>
               
            </div>
            <div slot="footer">
                <button class="_btn" type="default" @click="addModal = false">
                    close
                </button>
                <button
                    class="_btn"
                    type="primary"
                    @click="addCategory"
                    :disabled="isAdding"
                >
                    {{ isAdding ? "Adding..." : "Add Category" }}
                </button>
            </div>
        </Modal>

        <!-- edit modal -->
        <Modal
            v-model="editModal"
            title="Add Tag Name"
            :mask-closable="false"
            :closable="false"
            >
            <Input
                v-model="editData.categoryName"
                placeholder="Enter Category Name"
                style="width: 100%"
            />
            <div class="space"></div>
             <Upload v-show="isEdit"
                ref="editUploads"
                type="drag"
                action="app/upload_category"
                :headers = "{'x-csrf-token':token,'X-Requested-With':'XMLHttpRequest'}"
                :on-success="handleSuccess"
                :format="['jpg','jpeg','png']"
                :on-error="handleError"
                :max-size="2048"
                :on-format-error="handleFormatError"
                :on-exceeded-size="handleMaxSize"
            >
                <div style="padding: 20px 0">
                    <Icon
                        type="ios-cloud-upload"
                        size="52"
                        style="color: #3399ff"
                    ></Icon>
                    <p>Click or drag files here to upload</p>
                </div>
            </Upload>
            <div class="demo-upload-list" v-if="editData.iconImage" >
                <template >
                    <img :src="`${editData.iconImage}`">
                    <div class="demo-upload-list-cover">
                        <Icon type="ios-trash-outline" @click="handleRemove(editData.iconImage)"></Icon>
                    </div>
                </template>
               
            </div>
            <div slot="footer">
                <button class="_btn" type="default" @click="addModal = false">
                    close
                </button>
                <button
                    class="_btn"
                    type="primary"
                    @click="updateCategory"
                    :disabled="isAdding"
                >
                    {{ isAdding ? "Adding..." : "Update Category" }}
                </button>
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
            data: {categoryName: "",iconImage:""},
            editData: {categoryName: "",iconImage:""},
            addModal: false,
            editModal: false,
            isAdding: false,
            categories: [],
            index: -1,
            showDeleteModal: false,
            i: -1,
            deleteItem: {},
            isDeleting: false,
            token:'',
            isEdit:false
        };
    },
    methods: {
        async addCategory() {
            this.data.iconImage=`/uploads/${this.data.iconImage}`;
            const res = await this.callApi(
                "post",
                "/app/create_category",
                this.data
            );
            if (res.status === 201) {
                this.categories.unshift(res.data);
                this.data.categoryName = "";
                this.data.iconImage = "";
                this.addModal = false;
                this.success("Category has added  successfully");
            } else {
                if (res.status == 422) {
                    if(res.data.errors.categoryName){this.error(res.data.errors.categoryName[0])}
                    if(res.data.errors.iconImage){this.error(res.data.errors.iconImage[0])};
                } else {
                    this.swr();
                }
            }
        },
        async updateCategory() {
            const res = await this.callApi(
                "post",
                "/app/update_category",
                this.editData
            );
            if (res.status === 200) {
                this.categories[this.index].categoryName = this.editData.categoryName;
                this.categories[this.index].iconImage = this.editData.iconImage;
                this.editModal = false;
                this.success("Category has updated  successfully");
            } else {
                if (res.status == 422) {
                    if(res.data.errors.categoryName){this.error(res.data.errors.categoryName[0])};
                    if(res.data.errors.iconImage){this.error(res.data.errors.iconImage[0])};
                } else {
                    this.swr();
                }
            }
        },
        showEditModal(category, index) {
            let obj = {
                id: category.id,
                categoryName: category.categoryName,
                iconImage: category.iconImage,
            };
            this.editModal = true;
            this.editData = obj 
            this.index = index;
        },
   
        showDeletingModal(category, i) {
             const deleteModalObj={
                    showDeleteModal: true,
                    deleteUrl:'app/delete_category',
                    data:category,
                    isDeleted:false,
                    deletingIndex:i
                }
                this.showDeleteModal=true
                this.$store.commit('setDeletingModalObj',deleteModalObj)
        },
        handleSuccess (res, file) {
           this.data.iconImage=res
           if(this.isEdit==true){
            this.editData.iconImage=`/uploads/${res}`
           }
        },
         handleError (res, file) {
            this.$Notice.warning({
                title: 'The file format is incorrect',
                desc: `${file.errors.file.length ? file.errors.file[0]:'Something went wrong !'}`,
            })
        },
        handleFormatError (file) {
            this.$Notice.warning({
                title: 'The file format is incorrect',
                desc: 'File format of ' + file.name + ' is incorrect, please select jpg or png.'
            });
        },
        handleMaxSize (file) {
            this.$Notice.warning({
                title: 'Exceeding file size limit',
                desc: 'File  ' + file.name + ' is too large, no more than 2M.'
            });
        },
        async handleRemove(img){
            
            (this.addModal==true)?img=`/uploads/${img}`:img
            const res =await this.callApi('post','/app/delete_icon',{iconImage:img})
            if(res.status !=200){
               
                this.data.iconImage=image
                this.swr();
            }else{
                this.isEdit=true
                this.$refs.uploads.clearFiles();
                this.$refs.editUploads.clearFiles();
                this.data.iconImage='';
                this.editData.iconImage='';
                this.success('Icon image deleted')
            }
        }
    },
    async created() {
         this.token=window.Laravel.csrfToken
        const res = await this.callApi("get", "/app/get_category");
        if (res.status == 200) {
            this.categories = res.data;
        } else {
            this.swr();
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
                this.categories.splice(obj.deletingIndex,1)
            }
        }
     }
};
</script>
<style>
    .demo-upload-list{
        display: inline-block;
        width: 60px;
        height: 60px;
        text-align: center;
        line-height: 60px;
        border: 1px solid transparent;
        border-radius: 4px;
        overflow: hidden;
        background: #fff;
        position: relative;
        box-shadow: 0 1px 1px rgba(0,0,0,.2);
        margin-right: 4px;
    }
    .demo-upload-list img{
        width: 100%;
        height: 100%;
    }
    .demo-upload-list-cover{
        display: none;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0,0,0,.6);
    }
    .demo-upload-list:hover .demo-upload-list-cover{
        display: block;
    }
    .demo-upload-list-cover i{
        color: #fff;
        font-size: 20px;
        cursor: pointer;
        margin: 0 2px;
    }
</style>
