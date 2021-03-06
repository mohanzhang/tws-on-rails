class StaticController < ApplicationController
  before_filter :away_ye_waitlisted, except: [:index, :jfdi_signup, :hosting, :about]
  before_action :use_new_styles

  def index
    @press = {
      'fast-company' => 'http://fastcompany.com',
      'forbes' => 'http://forbes.com',
      'huffington-post' => 'http://www.huffingtonpost.com/dr-shelley-prevost/creating-a-better-world-o_b_6061626.html',
      'tedxteen' => 'http://www.tedxteen.com/speakers-performers/tedxteen-2014-london/237-ankit-shah'
    }
    @cities = City.visible
    @cities_by_host  = Hash.new([]).merge(
      @cities.group_by { |x|
        if (x.fully_brewed? || x.warming_up?)
          :hosts
        else
          :no_hosts
        end
      })
  end

  def hosting
  end

  def about
  end

  def jfdi_signup
    @full_form = !request.xhr?
    return redirect_to profile_path if current_user
    if @full_form
      render 'registrations/sign_up'
    else
      render 'shared/_new_sign_up', layout: @full_form
    end
  end
end
