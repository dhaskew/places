class MiscPagesController < ApplicationController
 skip_before_filter :authenticate_user!, only: :landing_page
 layout "landing", only: :landing_page
  
  def user_setup
  end

  def landing_page
  end

  def dashboard
  end

  def rewrite_visit
    visit = params[:visit_id]
    location = params[:loc_id]
    @existing_visit = current_user.visits.find_by_id(visit)
    @existing_visit.update_attributes location_id: location
    respond_to do |format|
      format.json { render json:@existing_visit, status: :ok}
      format.html { redirect_to :dashboard }
    end
  end

  def new_location
    l = current_user.locations.new
    l.name = params[:name]
    l.address = params[:address]
    l.save!
    locations = current_user.locations
    respond_to do |format|
      format.json { render json:locations, status: :ok}
      format.html { redirect_to :dashboard }
    end
  end

  def visit_location_remove
    v = current_user.visits.find_by_id(params[:id])
    v.update_attributes location_id: nil
    @visits = current_user.visits.includes(:location)
    respond_to do |format|
      format.json { render json:visits, status: :ok }
      format.html { redirect_to :dashboard }
    end
  end

  def show_location
    loc_id = params[:id]
    @location = current_user.locations.find_by_id(loc_id)
    @visits = current_user.visits.where(location_id: loc_id)
    @locations = current_user.locations
  end

  def visit_show
    @visit_name = params[:name] 
    @visits = current_user.visits.where(name: @visit_name).includes(:location)
    @locations = current_user.locations
  end

  def lengthy_visits
    cvisits = current_user.visits.where(location: nil).where.not(name: 'Elaine Quinilty').group(:name,:latitude,:longitude).sum(:duration)
    cvisits = cvisits.map{|key,value| {name:key[0], lat:key[1], lng:key[2], count:value}}  
    cvisits = cvisits.sort_by { |hash| hash[:count] }.reverse

    temp_locations = current_user.visits.where.not(location_id:nil).group("location_id").sum(:duration)

    clocations = []

    temp_locations.keys.each do |key|
      cloc = current_user.locations.find_by_id(key)
      cname = cloc.name
      ccount = temp_locations[key]
      clat = cloc.latitude
      clng = cloc.longitude
      clocations << { name: cname, id: key, count: ccount, lat: clat, lng: clng }
    end

    ctotal = (cvisits + clocations).sort_by{ |hash| hash[:count] }.reverse

    respond_to do |format|
      format.json { render json:ctotal, status: :ok }
      format.html { redirect_to :dashboard }
    end

  end

  def popular_visits
    visits = current_user.visits.where.not(name: 'Elaine Quinilty').group(:name, :latitude, :longitude).count
    #visits = current_user.visits.group(:name, :latitude, :longitude).count
    
    visits = visits.map{|key,value| {name:key[0], lat:key[1], lng:key[2], count:value}}  
    visits = visits.sort_by { |hash| hash[:count] }.reverse
    respond_to do |format|
      format.json { render json:visits, status: :ok }
      format.html { redirect_to :dashboard }
    end
  end

  def inbox
    @messages = current_user.messages 
    respond_to do |format|
      format.json { render json:current_user.messages, status: :ok }
      format.html { redirect_to :dashboard }
    end
  end

  def delete_message
    message_id = params["id"]
    message = current_user.messages.where(id: message_id)
    Message.destroy(message)
    @messages = current_user.messages
    respond_to do |format|
      format.json { render json:current_user.messages, status: :ok }
      format.html { redirect_to :dashboard }
    end
  end

  def evernote_setup
    token = current_user.evernote_token 
    client = EvernoteOAuth::Client.new(token: token)
    note_store = client.note_store
    evernote_notebooks = note_store.listNotebooks(token)
    @notebooks = evernote_notebooks.map { |nb| { name:nb.name,guid:nb.guid }}
  end

  def evernote_import
    notebook = params["notebook"]
    token = current_user.evernote_token
    client = EvernoteOAuth::Client.new(token: token)
    note_store = client.note_store
    search_info = Evernote::EDAM::NoteStore::NoteFilter.new
    search_info.notebookGuid = notebook
    search_results = note_store.findNotes(search_info,0,1000)
    total_notes = search_results.totalNotes
    (0...total_notes).each do |i|
      sleep 0.25
      begin
        next_note = note_store.getNote(token,search_results.notes[i].guid, true,false,false,false)
        en = current_user.enotes.new
        en.title = next_note.title
        en.guid = next_note.guid
        en.note = next_note.content
        en.save!

        parsed = EnoteParser.parse(next_note.content)
        parsed.visits.each do |visit|
          v = en.visits.new
          v.name = visit[:name]
          v.link = visit[:href]
          v.address = visit[:address]
          v.duration = visit[:mins]
          v.save!
        end      
      rescue
        puts "something bad happened"
      end

    end
    redirect_to :dashboard
  end

end
