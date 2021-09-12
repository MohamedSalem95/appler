<template>
  <div id="">
      <button v-if="visible" class="btn btn-outline-success btn-sm fw-bold" @click="approveUser"> دخول </button>
    
  </div>
</template>

<script>
export default {
  name: 'Approve',
    props: {
      id: Number,
      status: Number
    },
  data: function () {
    return {
      visible: true
    }
  },
  channels: {
    AppointmentChannel: {
      connected() {
        console.log('connected from Approve')
      },
      received(data) {},
      disconnected() {}
    },
    AppointmentStatusChannel: {
      connected() {
        console.log('connected from Approve')
      },
      received(data) {
        if(data['status'] == 3 && data['id'] == this.id) this.visible = false
      },
      disconnected() {}
    }
  },
  methods: {
      approveUser() {
          this.$cable.perform({
              channel: 'AppointmentChannel',
              action: 'approve',
              data: {
                  id: this.id
              }
          })
          this.visible = false
      }
  },
  mounted () {
    if(this.status == 5 || this.status == 4 || this.status == 2 || this.status == 3) {
      this.visible = false
    }
    this.$cable.subscribe({
      channel: 'AppointmentChannel'
    })
    this.$cable.subscribe({
      channel: 'AppointmentStatusChannel'
    })
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
