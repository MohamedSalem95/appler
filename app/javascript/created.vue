<template>
  <div id="">
        <p class="text-success fw-bold text-end fs-5"> المواعيد المضافه حديثا </p>
      <table class="table table-sm table-bordered">
          <tbody>

                <tr v-for="user in users" :key="user.name" class="bg-light">
           <td> <b> -- </b> </td>
            <td> <b> {{  user.name  }} </b> </td>
            <td> <b class="text-uppercase">  {{ user.app_time | moment('hh:mm a') }} </b> </td>
            <td>
                <b v-if="user.description === '' ">
                    لا يوجد تفاصيل.
                </b>
                <b v-else>
                    {{ user.description }}
                </b>
            </td>
            <td>
                <Status v-bind:id="user.id" v-bind:status="user.status"></Status>
                
            </td>

            <td>
                <Approve v-bind:id="user.id" v-bind:status="user.status"></Approve>
            </td>

      </tr>
          </tbody>

      </table>
  </div>
</template>

<script>
import axios from 'axios'

import Approve from './approve.vue'
import Status from './status.vue'

let devUrl = 'http://127.0.0.1:3000/appointments/'
let prodUrl = 'https://appmanager251.herokuapp.com/appointments/'

export default {
  components: {
      Approve,
      Status
  },
  data: function () {
    return {
        count: 0,
        users: [],
        //visible: true
    }
  },
  channels: {
    AppointmentCreateChannel: {
      connected() {
        console.log('connected from create')
      },
      received(data) {
          console.log(data)
          this.id = data['id']
          axios.get(`${devUrl}${this.id}`).then(res => {
              console.log(res['data'])
              this.users.splice(0, 0, res['data'])
          })
      },
      disconnected() {}
    }
  },
  methods: {},
  mounted () {
    /*
    if(this.status == 5 || this.status == 4 || this.status == 2 || this.status == 3) {
      this.visible = false
    }*/
    this.$cable.subscribe({
      channel: 'AppointmentCreateChannel'
    })
  }
}
</script>

<style scoped>

</style>
