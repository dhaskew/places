class MiscPagesController < ApplicationController
 skip_before_filter :authenticate_user!, only: :landing_page
 layout "landing", only: :landing_page
  
  def user_setup
  end

  def landing_page
  end

  def dashboard
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
    #nb = note_store.getNotebook(notebooks[1].guid)
    #filter = Evernote::EDAM::NoteStore::NoteFilter.new
    #filter.notebookGuid = nb.guid
    #note_list = note_store.findNotes(filter, 0, 10)
    #sample_note = note_store.getNote(token,"4d9d90c7-46ea-435c-a3b2-ecf5f3e1e13b", true,false,false,false)
    #note_title = sample_note.title
    #note_content = sample_note.content
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
      puts search_results.notes[i].guid
    end
    redirect_to :dashboard
  end

end
