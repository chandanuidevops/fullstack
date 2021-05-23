<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
                <div
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20"
                >
                    <p class="_title0">
                        User
                        <button
                            class="_btn"
                            type="primary"
                            @click="addModal = true"
                            v-if="isWritePermitted"
                        >
                            <Icon type="md-add" />Add
                        </button>
                    </p>

                    <div class="_overflow _table_div">
                        <table class="_table">
                            <!-- TABLE TITLE -->
                            <tr>
                                <th>ID</th>
                                <th>User Name</th>
                                <th>Email</th>
                                <th>User Type</th>
                                <th>Created At</th>
                                <th>Action</th>
                            </tr>
                            <!-- TABLE TITLE -->

                            <!-- ITEMS -->
                            <tr
                                v-for="(user, i) in users"
                                :key="i"
                                v-if="users.length"
                            >
                                <td>{{ user.id }}</td>
                                <td class="_table_name"> {{ user.fullName }} </td>
                                <td >{{ user.email }}</td>
                                <td >{{ user.role_id }}</td>
                                <td>{{ user.created_at }}</td>
                                <td>
                                    <button
                                        class="_btn _action_btn edit_btn1"
                                        type="button"
                                        @click="showModal(user, i)"
                                         v-if="isUpdatePermitted"
                                    >
                                        Edit
                                    </button>
                                    <button
                                        class="_btn _action_btn make_btn1"
                                        type="button"
                                        @click="showDeletingModal(user, i)"
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
        <Modal
            v-model="addModal"
            title="Add User"
            :mask-closable="false"
            :closable="false"
        >
            <div class="space">
                <Input
                    type="text"
                    v-model="data.fullName"
                    placeholder="Enter Full Name"
                    style="width: 300px"
                />
            </div>
            <div class="space">
                <Input
                    type="email"
                    v-model="data.email"
                    placeholder="Enter Email"
                    style="width: 300px"
                />
            </div>
            <div class="space">
                <Input
                    type="password"
                    v-model="data.password"
                    placeholder="Enter Password"
                    style="width: 300px"
                />
            </div>
            <div class="space">
                <Select style="width:300px"  v-model="data.role_id" placeholder="Select admin type">
                     <Option :value="r.id" v-for="(r,i) in roles" :key="i"  v-if="roles.length" >{{r.roleName}}</Option>
                </Select>
            </div>

            <div slot="footer">
                <button class="_btn" type="default" @click="addModal = false">
                    close
                </button>
                <button
                    class="_btn"
                    type="primary"
                    @click="addAdmin"
                    :disabled="isAdding"
                >
                    {{ isAdding ? "Adding..." : "Add Admin" }}
                </button>
            </div>
        </Modal>
        <Modal
            v-model="editModal"
            title="Edit User "
            :mask-closable="false"
            :closable="false"
        >
            <div class="space">
                <Input
                    type="text"
                    v-model="editData.fullName"
                    placeholder="Enter Full Name"
                    style="width: 300px"
                />
            </div>
            <div class="space">
                <Input
                    type="email"
                    v-model="editData.email"
                    placeholder="Enter Email"
                    style="width: 300px"
                />
            </div>
            <div class="space">
                <Input
                    type="password"
                    v-model="editData.password"
                    placeholder="Enter Password"
                    style="width: 300px"
                />
            </div>
            <div class="space">
                <Select style="width:300px"  v-model="editData.role_id" placeholder="Select admin type">
                    <Option value="Admin" v-for="(r,i) in roles" :key="i"  v-if="roles.length" >{{r.roleName}}</Option>
                </Select>
            </div>
            <div slot="footer">
                <button class="_btn" type="default" @click="editModal = false">
                    close
                </button>
                <button
                    class="_btn"
                    type="primary"
                    @click="editUser"
                    :disabled="isAdding"
                >
                    {{ isAdding ? "Updating..." : "Update User" }}
                </button>
            </div>
        </Modal>
        <!-- delete alert modal -->
        <delete-modal></delete-modal>
    </div>
</template>
<script>
import deleteModal from "../common/DeleteComponent";
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      data: {
        fullName: "",
        email: "",
        password: "",
        role_id: "",
      },
      editData: {
        fullName: "",
        email: "",
        password: "",
        role_id: "",
      },
      addModal: false,
      editModal: false,
      isAdding: false,
      users: [],
      index: -1,
      showDeleteModal: false,
      i: -1,
      deleteItem: {},
      isDeleting: false,
      roles:[],
    };
  },
  methods: {
    async addAdmin() {
        console.log(this.data)
      const res = await this.callApi("post", "/app/create_user", this.data);
     
      if (res.status === 201) {
        this.users.unshift(res.data);
        this.addModal = false;
        this.success("User has added  successfully");
      } else {
        if (res.status == 422) {
          for (let i in res.data.errors) {
            this.error(res.data.errors[i]);
          }
        } else {
          this.swr();
        }
      }
    },
    async editUser() {
      const res = await this.callApi("post", "/app/update_user", this.editData);
      if (res.status === 200) {
        this.users[this.index] = this.editData;
        this.editModal = false;
        this.success("User User updated  successfully");
      } else {
        if (res.status == 422) {
          for (let i in res.data.errors) {
            this.error(res.data.errors[i]);
          }
        } else {
          this.swr();
        }
      }
    },
    showModal(user, index) {
      let obj = {
        id: user.id,
        fullName: user.fullName,
        email: user.email,
        role_id: user.role_id,
      };
      this.editModal = true;
      this.editData = obj;
      this.index = index;
    },
    showDeletingModal(user, i) {
      const deleteModalObj = {
        showDeleteModal: true,
        deleteUrl: "app/delete_user",
        data: user,
        isDeleted: false,
        deletingIndex: i,
      };
      this.showDeleteModal = true;
      this.$store.commit("setDeletingModalObj", deleteModalObj);
    },
  },
  async created() {
    const [res, resRole]=await Promise.all([
        this.callApi("get", "/app/get_users"),
        this.callApi("get", "/app/get_roles")
    ])
  
    if (res.status == 200) {
      this.users = res.data;
    } else {
      this.swr();
    }
     if (resRole.status == 200) {
      this.roles = resRole.data;
    } else {
      this.swr();
    }
  },
  components: {
    deleteModal,
  },
  computed: {
    ...mapGetters(["getDeletedModalObj"]),
  },
  watch: {
    getDeletedModalObj(obj) {
      if (obj.isDeleted) {
        this.users.splice(obj.deletingIndex, 1);
      }
    },
  },
};
</script>
