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
      gs.sections.create! section_info
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
    if @section.update!(section_info)
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
    params.permit(:name, :keep, :parent_id, :parent_type, keys: [], traits: [:name], child_sections: []).merge(get_sec_params)
  end

  def section_info
    {
      name: params['name'],
      keep: params['keep'],
      keys: params['keys'],
      traits: get_traits(params['traits']),
      child_sections: get_child_sections(params['child_sections'])
  }.merge(get_sec_info params)
  end

  def get_traits h
    return_traits = []
    n = 0
    while n < h.length
      return_traits.push({ name: h[n]['name'] })
      n+=1
    end
    return_traits
  end

  def get_child_sections sections
    return_sections = []
    n = 0
    if sections
      while n < sections.length
        return_sections.push({
          name: sections[n]['name'],
          keep: sections[n]['keep'],
          child_sections: get_child_sections(sections[n]['child_sections'])
        }.merge(get_sec_info sections[n]))
        n+=1
      end
    end
    return_sections
  end

  def get_sec_params
    reg_ex = /(\bsec_)\w*/
    sec_params = []
    params.each_pair do |k, v|
      reg_ex.match(k) { sec_params << k }
    end
    sec_params
  end

  def get_sec_info h
    reg_ex = /(\bsec_)\w*/
    sec_info = {}
    sec_keys = []
    h.each_pair do |k, v|
      reg_ex.match(k) {
        sec_info.merge!({k => v})
        sec_keys << k
      }
    end
    sec_info.merge!({ keys: sec_keys })
    sec_info
  end
end
