import Vue from 'vue'
import App from './form.vue'
import SectionForm from './section.vue'

document.addEventListener('DOMContentLoaded', () => {

  const element = document.getElementsByTagName("gameSystemForm")[0]
  const props = JSON.parse(element.getAttribute('data'))
  if (element != null && props != null) {
    var gameSystemForm = new Vue({
      name: 'gameSystemForm',
      el: 'gameSystemForm',
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