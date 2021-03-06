class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :update, :destroy]

  # GET /notes
  def index
    # makes sure that we are only grabbing notes of the particular user
    @notes = Note.where(user_id: current_user)

    render json: @notes
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # POST /notes
  def create
    @note = Note.new(note_params)
    # makes sure every note is assigned a user_id at creation
    @note.user = current_user

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def note_params
      params.require(:note).permit(:message, :user_id)
    end
end
