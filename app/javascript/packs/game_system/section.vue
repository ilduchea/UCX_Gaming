<template>
  <div>
    <label for="name">Name</label>
    <input v-model="section.name">
    <label for="keep">Keep</label>
    <input type="checkbox" v-model="section.keep">
    <ul>
      <li v-if="sectionArray(section.traits)">Traits:</li>
      <li v-for="trait in section.traits">
        <label for="trait.name">Name</label>
        <input v-model="trait.name"><br>
        <label for="trait.property">Property</label>
        <input v-model="trait.property"><br>
      </li>
    </ul>
    <ul>
      <li v-if="sectionArray(section.child_sections)">Child Sections:</li>
      <li v-for="section in section.child_sections">
        <sectionForm parentType="sec" :section.sync="section"></sectionForm>
      </li>
    </ul>
    <button v-on:click="addTrait(section)">Add Trait</button>
    <button v-on:click="addChildSection(section)">Add Child Section</button>
    <button v-if="parentType != 'sec'" v-on:click="saveSection(section)">Save</button>
  </div>
</template>

<script>
  import Vue from 'vue';
  import VueResource from 'vue-resource';

  Vue.use(VueResource);

  export default {
    name: 'sectionForm',
    props: {
      'section': Object,
      'parentType': String,
      'parentId': String
    },
    data: function() {
      return {
        
      }
    },
    methods: {
      sectionArray: function(array) {
        if (array != undefined) {
          return array.length > 0 ? true : false;
        } else {
          return false
        }
      },
      addChildSection: function(section) {
        section.child_sections.push({
          name: '',
          keep: false,
          traits: [],
          child_sections: []
        });
      },
      addTrait: function(section) {
        section.traits.push({
          name: '',
          property: ''
        });
      },
      saveSection: function(section) {
        if (this.section._id) {
          if (this.parentType === 'gs') {
            this.$http.patch(`/sections/${this.section._id.$oid}`, {
              name: this.section.name,
              keep: this.section.keep,
              traits: this.section.traits,
              child_sections: this.section.child_sections
            });
          }
        }else {
          if (this.parentType === 'gs') {
            this.$http.post('/sections', {
              name: this.section.name,
              keep: this.section.keep,
              traits: this.section.traits,
              child_sections: this.section.child_sections,
              parent_type: this.parentType,
              parent_id: this.parentId
            });
          }
        }
      }
    }
  }
</script>

<style scoped>
  label {
    text-align: center;
    color: purple;
  }
  ul {
    list-style-type: none;
  }
  .col-2 {
    width: 50%;
  }
  .row {
    display: flex;
  }

</style>