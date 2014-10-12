class MiscPagesController < ApplicationController
 skip_before_filter :authenticate_user!, only: :landing_page
 layout "landing", only: :landing_page
  
  def user_setup
  end

  def landing_page
  end

  def dashboard
  end

  def popular_visits
    visits = current_user.visits.group(:name, :latitude, :longitude).count
    visits = visits.map{|key,value| {name:key[0], lat:key[1], lng:key[2], count:value}}  
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
    search_results = note_store.findNotes(search_info,0,10)
    total_notes = search_results.totalNotes
    (0...total_notes).each do |i|
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

    end
    redirect_to :dashboard
  end

end
