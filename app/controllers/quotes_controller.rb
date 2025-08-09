class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :vote, :increment_views]
  
  # GET /
  # GET /quotes
  def index
    @quotes = Quote.includes(:user, :comments, :votes).recent.limit(20)
    @current_quote = @quotes.first
    @quote_count = Quote.count
  end
  
  # GET /quotes/:id
  def show
    @quote.increment_views!
    @comments = @quote.comments.recent.includes(:quote)
    @comment = Comment.new
    @previous_quote = Quote.where("id < ?", @quote.id).order(id: :desc).first
    @next_quote = Quote.where("id > ?", @quote.id).order(id: :asc).first
    
    respond_to do |format|
      format.html
      format.json { render json: quote_json(@quote) }
    end
  end
  
  # GET /quotes/new
  def new
    @quote = Quote.new
    @user = User.new
  end
  
  # POST /quotes
  def create
    @user = User.find_or_initialize_by(
      first_name: user_params[:first_name], 
      last_name: user_params[:last_name]
    )
    @user.assign_attributes(user_params) if @user.new_record?
    
    @quote = @user.quotes.build(quote_params)
    
    # Validate both user and quote
    if @user.valid? && @quote.valid?
      @user.save! if @user.new_record?
      @quote.save!
      redirect_to @quote, notice: '🎉 Sözünüz başarıyla yayınlandı!'
    else
      # Prepare objects for re-rendering the form
      @quote = Quote.new(quote_params) unless @quote.persisted?
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH /quotes/:id/vote
  def vote
    ip_address = request.remote_ip
    vote_type = params[:vote_type]
    
    # Mevcut oyu kontrol et
    existing_vote = @quote.votes.find_by(ip_address: ip_address)
    
    if existing_vote
      if existing_vote.vote_type == vote_type
        # Aynı oy ise kaldır (toggle)
        existing_vote.destroy
        message = "Oyunuz kaldırıldı"
      else
        # Farklı oy ise güncelle
        existing_vote.update(vote_type: vote_type)
        message = "Oyunuz güncellendi"
      end
    else
      # Yeni oy oluştur
      @quote.votes.create(vote_type: vote_type, ip_address: ip_address)
      message = "Oyunuz kaydedildi"
    end
    
    respond_to do |format|
      format.json { 
        render json: { 
          success: true, 
          message: message,
          likes_count: @quote.reload.likes_count,
          dislikes_count: @quote.dislikes_count,
          user_vote: @quote.votes.find_by(ip_address: ip_address)&.vote_type
        } 
      }
      format.html { redirect_to @quote, notice: message }
    end
  end
  
  # PATCH /quotes/:id/increment_views  
  def increment_views
    @quote.increment_views!
    
    respond_to do |format|
      format.json { render json: { views_count: @quote.views_count } }
    end
  end
  
  # GET /quotes/random
  def random
    @quote = Quote.random_order.first
    
    if @quote
      redirect_to @quote
    else
      redirect_to root_path, alert: "Henüz hiç söz eklenmemiş."
    end
  end
  
  # GET /quotes/jokes
  def jokes
    @quotes = Quote.jokes.includes(:user, :comments, :votes).recent.limit(20)
    @current_quote = @quotes.first
    @quote_count = Quote.jokes.count
    
    render :index
  end
  
  # GET /quotes/inspiring  
  def inspiring
    @quotes = Quote.inspiring.includes(:user, :comments, :votes).recent.limit(20)
    @current_quote = @quotes.first
    @quote_count = Quote.inspiring.count
    
    render :index
  end
  
  private
  
  def set_quote
    @quote = Quote.find(params[:id])
  end
  
  def quote_params
    params.require(:quote).permit(:content, :quote_type)
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :linkedin_url)
  end
  
  def quote_json(quote)
    {
      id: quote.id,
      content: quote.content,
      quote_type: quote.quote_type,
      views_count: quote.views_count,
      likes_count: quote.likes_count,
      dislikes_count: quote.dislikes_count,
      user: {
        full_name: quote.user.full_name,
        initials: quote.user.initials
      },
      comments_count: quote.comments.count,
      created_at: quote.created_at.strftime("%d %B %Y")
    }
  end
end
