<template>
  <div id="">
    <span v-if="appStatus == 1" class="badge bg-info"> لم يدخل بعد </span>



    <span v-if="appStatus == 2" class="badge bg-primary"> تم الموافقه </span>


    <!--<span v-if="appStatus == 3 && date == getDate" class="badge bg-success"> لم يدخل بعد (مؤجل) </span>-->

    <span v-if="appStatus == 3" class="badge bg-warning"> تم التاجيل </span>



    <!-- <span class="badge bg-info"> لم يدخل بعد (مؤجل) </span> -->



    <span v-if="appStatus == 4" class="badge bg-danger"> تم الرفض </span>



    <span v-if="appStatus == 5" class="badge bg-success"> تم الدخول </span>
</div>
</template>

<script>
import currentVue from './current.vue'
export default {
    props: {
        id: Number,
        status: Number
    },
    data: function () {
        return { appStatus: this.status }
    },
    channels: {
        AppointmentStatusChannel: {
            connected() {
                console.log('connected from Status !')
            },
            received(data) {
                console.log(data)
                if(data['id'] == this.id) this.appStatus = data['status']
            },
            disconnected() {}
        }
    },
    computed: {
        getDate: () => {
            let currentDate = new Date
            currentDate.setHours(0, 0, 0, 0)
            return currentDate
        }
    },
    mounted () {
        this.$cable.subscribe({
            channel: 'AppointmentStatusChannel'
        })

        console.log(date)
        console.log(this.getDate)
    }
}
</script>

<style scoped>
</style>
