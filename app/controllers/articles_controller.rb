class ArticlesController < ApplicationController

  before_filter :require_login, :except => [:index, :show]
  before_filter :can_edit, :only => [:edit, :update, :destroy]

  def index
    @articles = Article.get
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.new(params[:article])
    if @article.save
      redirect_to(@article)
    else
      render :action => "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to(@article)
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to(blog_path)
  end
end
