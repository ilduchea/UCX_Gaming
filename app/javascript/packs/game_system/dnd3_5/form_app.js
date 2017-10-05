import Vue from 'vue'
import App from './form.vue'
import SectionForm from './section.vue'

document.addEventListener('DOMContentLoaded', () => {

  const element = document.getElementsByTagName("characterForm")[0]
  const props = JSON.parse(element.getAttribute('data'))
  if (element != null && props != null) {
    var characterForm = new Vue({
      name: 'characterForm',
      el: 'characterForm',
      render: h => h(App, {
        props
      }),
      data: {
        props
      },
      components: {
        'sectionForm': SectionForm
      }
    });
  }

})