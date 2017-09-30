class SectionsController < ApplicationController

  def show
    @section = Section.find(params[:id])
    respond_to do |f|
      f.html
      f.js {  }
    end
  end

  def create
    parent_id = section_params['parent_id']
    parent_type = section_params['parent_type']
    if (parent_type === 'gs')
      gs = GameSystem.find(parent_id)
      gs.sections.create section_info
    end
    if (parent_type === 'sec')
      sec = Section.find(parent_id)
      sec.child_sections.create section_info
    end
    respond_to do |f|
      f.html 
      f.js {  }
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section.update!(section_params)
      respond_to do |f|
        f.html
        f.js {  }
      end
    end
  end

  def destroy
    @section = Section.find(params[:id])
    if @section.destroy
      respond_to do |f|
        f.html
        f.js {  }
      end
    end
  end

private
  def section_params
    params.permit(:name, :keep, :parent_id, :parent_type, traits: [], child_sections: [])
  end

  def section_info
    {
      name: params['name'],
      keep: params['keep'],
      traits: get_traits(params['traits']),
      child_sections: get_child_sections(params['child_sections'])
    }
  end

  def get_traits traits
    return_traits = []
    n = 0
    while n < traits.length
      return_traits.push({
        name: traits[n]['name'],
        property: traits[n]['property']
      })
      n+=1
    end
    return_traits
  end

  def get_child_sections sections
    return_sections = []
    n = 0
    while n < sections.length
      return_sections.push({
        name: sections[n]['name'],
        keep: sections[n]['keep'],
        traits: get_traits(sections[n]['traits']),
        child_sections: get_child_sections(sections[n]['child_sections'])
      })
      n+=1
    end
    return_sections
  end
end
