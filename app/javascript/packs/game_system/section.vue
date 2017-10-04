<template>
  <div>
    <label for="name">Name</label>
    <input v-model="section.name">
    <label for="keep">Keep</label>
    <input type="checkbox" v-model="section.keep"><br>
    <p>Properties:</p>
    <span v-for="trait in traits">
      <input v-model="trait.name">
    </span>
    <button v-on:click="addTrait()">Add Property Name</button>
    <!-- <button v-if="child_sections.length > 0" v-on:click="updateTraitKeys()">Update Child Property Names</button> -->
    <ul v-if="child_sections.length > 0">
      <li class="toggle" v-on:click="toggleChildern">{{section.name}}:</li>
      <li class="child-section" v-show="childToggle" v-for="child, index in child_sections">
        <span v-for="key in child.keys">
          <label>{{ key.slice(4) }}:</label>
          <input v-model="child[key]">
        </span>        
        <button v-on:click="deleteChildSection(index)">Delete</button>
      </li>
    </ul>
    <button v-on:click="addChildSection()">Add {{section.name}}</button>
    <button v-on:click="saveSection(section)">Save</button>
    <button v-on:click="deleteSection(section)">Delete</button>
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
      'parentId': String,
      'id': Number
    },
    data: function() {
      if (this.section.child_sections === undefined) {
        this.section.child_sections = [];
      }
      return {
        traits: this.section.traits,
        child_sections: this.section.child_sections,
        childToggle: false
      }
    },
    created: function() {
      // console.log(this.section.traits.length);
      // console.log(this.section.traits);
    },
    methods: {
      addChildSection: function() {
        let h = {
          name: '',
          keep: false,
          child_sections: [],
          keys: []
        };
        this.addTraitKeys(h, this.traits);
        this.child_sections.push(h);
      },
      addTraitKeys: function(h, a) {
        a.forEach(function(trait) {
          let cleanName = trait.name.split(' ').join('_');
          let key = 'sec_' + cleanName;
          h[key] = '';
          h.keys.push(key);
        });
      },
      addTrait: function() {
        this.traits.push({ name: '' });
      },
      // updateTraitKeys: function() {
        // fix later
      //   let that = this;
      //   this.section.child_sections.forEach(function(child) {
      //     let newTraits = that.traits;
      //     console.log('traits:', newTraits);
      //     console.log('child:', child);
      //     // addTraitKeys(child, newTraits);
      //   });
      // },
      saveSection: function(section) {
        if (this.section._id) {
          if (this.parentType === 'gs') {
            this.$http.patch(`/sections/${this.section._id.$oid}`, this.section);
          }
        }else {
          if (this.parentType === 'gs') {
            this.section.parent_id = this.parentId;
            this.section.parent_type = this.parentType;
            this.section.traits = this.traits;
            this.section.child_sections = this.child_sections;
            this.$http.post('/sections', this.section);
          }
        }
      },
      deleteSection: function(section) {
        if (this.parentType === 'gs') {
          this.$http.delete(`/sections/${this.section._id.$oid}`, this.section).then(r => {
            this.$emit('section-remove', this.id);
          });
        }
      },
      deleteChildSection: function(i) {
        this.child_sections.splice(i, 1);
      },
      toggleChildern: function() {
        if (this.childToggle) {
          this.childToggle = false;
        } else {
          this.childToggle = true;
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
  .toggle:hover {
    cursor: pointer;
  }
  .child-section {
    border-bottom: 1px solid black;
    padding-bottom: 5px;
    margin-bottom: 5px; 
  }


</style>