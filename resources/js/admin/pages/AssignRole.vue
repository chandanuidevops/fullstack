<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20"
                >
                    <p class="_title0">
                        Role Management
                        <Select
                            style="width:300px"
                            v-model="data.id"
                            placeholder="Select admin type"
                            @on-change="changeAdmin()"
                        >
                            <Option
                                :value="r.id"
                                v-for="(r, i) in roles"
                                :key="i"
                                v-if="roles.length"
                                >{{ r.roleName }}</Option
                            >
                        </Select>
                    </p>

                    <div class="_overflow _table_div">
                        <table class="_table">
                            <!-- TABLE TITLE -->
                            <tr>
                                <th>Resource Name</th>
                                <th>Read</th>
                                <th>Write</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                            <!-- TABLE TITLE -->

                            <!-- ITEMS -->
                            <tr v-for="(r, i) in resources"
                                :key="i"
                                v-if="resources.length"
                            >
                                <td class="_table_name"> {{ r.resourceName }}</td>
                                <td> <Checkbox v-model="r.read" ></Checkbox></td>
                                <td >
                                     <Checkbox v-model="r.write" ></Checkbox>
                                </td>
                                <td> <Checkbox v-model="r.update" ></Checkbox></td>
                                <td>
                                   <Checkbox v-model="r.deletePermission" ></Checkbox>
                                </td>
                            </tr>
                            <!-- ITEMS -->
                            <div class="center_button">
                                <Button type="primary"
                                :loading="isSending"
                                :disabled="isSending"
                                @click="assignRoles"
                                >Assign</Button>
                            </div>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import deleteModal from "../common/DeleteComponent";
import { mapGetters } from "vuex";
export default {
    data() {
        return {
            data: {
                id: null
            },
            resources: [
                 { resourceName:'Home',read:false,write:false,update:false,deletePermission:false,name:'/' },
                { resourceName:'Tags',read:false,write:false,update:false,deletePermission:false,name:'tags' },
                { resourceName:'Category',read:false,write:false,update:false,deletePermission:false,name:'category' },
                { resourceName:'Role',read:false,write:false,update:false,deletePermission:false,name:'role' },
                { resourceName:'Assign Role',read:false,write:false,update:false,deletePermission:false,name:'assignRole' },
                 { resourceName:'Create Blog',read:false,write:false,update:false,deletePermission:false,name:'createBlog' },
                 { resourceName:'Blogs',read:false,write:false,update:false,deletePermission:false,name:'blogs' },
                { resourceName:'Admin users',read:false,write:false,update:false,deletePermission:false,name:'adminusers' },
               
            ],
             defaultResources: [
                   { resourceName:'Home',read:false,write:false,update:false,deletePermission:false,name:'/' },
                { resourceName:'Tags',read:false,write:false,update:false,deletePermission:false,name:'tags' },
                { resourceName:'Category',read:false,write:false,update:false,deletePermission:false,name:'category' },
                { resourceName:'Role',read:false,write:false,update:false,deletePermission:false,name:'role' },
                { resourceName:'Assign Role',read:false,write:false,update:false,deletePermission:false,name:'assignRole' },
                { resourceName:'Create Blog',read:false,write:false,update:false,deletePermission:false,name:'createBlog' },
                { resourceName:'Blogs',read:false,write:false,update:false,deletePermission:false,name:'blogs' },
                { resourceName:'Admin users',read:false,write:false,update:false,deletePermission:false,name:'adminusers' },
              
            ],
            roles:[],
            isSending:false,
        };
    },
    methods: {
      async  assignRoles(){
          let data= JSON.stringify(this.resources)
          const res = await this.callApi('post','app/assign_roles',{'permission':data,'id':this.data.id})
          if(res.status==200){
              this.success('Role has been assigned to successfully !')
              let index = this.roles.findIndex(role=>role.id==this.data.id)
              this.roles[index].permission=data
          }else{
              this.swr()
          }
        },
        changeAdmin(){
           let index = this.roles.findIndex(role=>role.id==this.data.id)
           let permission=this.roles[index].permission
           if(!permission){
              this.resources=this.defaultResources 
           }else{
               this.resources=JSON.parse(permission)
           }
        }
    },
    async created() {
        const res = await this.callApi("get", "/app/get_roles");
        if (res.status == 200) {
            this.roles = res.data;
            if(res.data.length){
                this.data.id=res.data[0].id
               if(res.data[0].permission){
                   this.resources=JSON.parse(res.data[0].permission)
               }
            }
        } else {
            this.swr();
        }
    }
};





</script>
