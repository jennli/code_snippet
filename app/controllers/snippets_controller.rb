class SnippetsController < ApplicationController
  before_action :find_snippet, only: [:show, :edit, :update, :destroy]

  def index
    # byebug
    if params[:lang_id]
      @snippets = Snippet.where("language_id = ?", params[:lang_id]).order("updated_at DESC")
    else
      @snippets = Snippet.all.order("updated_at DESC")
    end
  end

  def new
    if user_signed_in?
      @snippet = Snippet.new
    else
      redirect_to new_session_path, alert:"you need to sign in to create new snippets!"
    end
  end

  def create
    @snippet = Snippet.new snippet_params
    @snippet.user = current_user

    if@snippet.save
      redirect_to snippet_path(@snippet), notice:"success"
    else
      flash[:alert] = "error!!!!"
      render :new
    end
  end

  def show
    if @snippet.is_private == "true" && @snippet.user != current_user
      redirect_to root_path, alert:"You don't have permission to view this snippet"
    else
      @language = @snippet.language.kind
    end
  end

  def edit
    if can? :manage, @snippet
      render :edit
    else
      redirect_to @snippet, alert:"You are not the owner of this snippet"
    end
  end

  def update
    if can? :manage, @snippet
      if @snippet.update snippet_params
        redirect_to snippet_path(@snippet), notice:"Update success"
      else
        flash[:alert] = "Update failed"
        render :edit
      end
    else
      redirect_to @snippet, alert:"You are not allowed to update because you are not the owner of this snippet"
    end
  end

  def destroy
    if can? :manage, @snippet
      @snippet.destroy
      redirect_to snippets_path, notice:"snippet deleted"
    else
      redirect_to @snippet, alert:"You are not the owner of this snippet"
    end
  end

  private

  def snippet_params
    params.require(:snippet).permit(:title, :body, :language_id, :is_private)
  end

  def find_snippet
    @snippet = Snippet.find params[:id]
  end

end
