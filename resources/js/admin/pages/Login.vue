<template>
    <div>
        <div class="content" style="margin-left:0px">
            <div class="container-fluid">
               
                <div  style="width: 350px;margin:auto"
                    class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20"
                >
                 <h4>Login to dashboard</h4>
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
                        <button class="_btn" type="primary"  @click="login" >
                            Submit
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return{
            data:{
                email:'',
                password:'',
            },
            isLogin:false,
              token:'',
        }
    },
    methods:{
        async login(){
             const res = await this.callApi(
                "post",
                "/app/admin_login",
                this.data
            );
              if (res.status === 200) {
                this.success(res.data.msg);
                // this.$router.push({ name: '/' })
                window.location.href = '/';
            }else{
                if (res.status == 422) {
                    for(let i in res.data.errors){
                        this.error(res.data.errors[i]);
                    }
                } else {
                    if(res.status == 401){
                         this.success(res.data.msg);
                    }else{
                        this.swr();
                    }
                }
            }
        }
    },
       async created() {
          
         this.token=window.Laravel.csrfToken
       
    },
};
</script>

<style></style>
