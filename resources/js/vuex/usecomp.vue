<template>
    <div>
        <div class="content">
            <div class="container-fluid">
                I will show how will other component react on changes
<br />
                 current counter: {{counter}}
            <br />
            <button @click="changeCounter" type="info btn">Change</button>
            <use-comp></use-comp>
            <use-compb></use-compb>
            <use-compc></use-compc>
            </div>
           
        </div>
    </div>
</template>

<script>
import useComp from './compA'
import useCompb from './compB'
import useCompc from './compC'
import {mapGetters, mapActions} from 'vuex'
export default {
    data(){
        return{

        }
    },
    components:{
    useComp,
    useCompb,
    useCompc
    },
    methods:{
        // ...mapActions([
        //         'changeCounterAction'
        // ]),
        changeCounter(){
            this.$store.dispatch('changeCounterAction',1)
            // this.$store.commit('changeTheCounter',1)
        },
        runCounterChange(){
            console.log('counter change')
        }
    },
    computed:{
        ...mapGetters({
            'counter':'getCounter'
        })
    },
    watch:{
        counter(value){
            console.log('counter change ',value)
            this.runCounterChange()
        }
    }
};
</script>

<style></style>
