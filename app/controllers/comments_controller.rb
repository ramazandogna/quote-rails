class CommentsController < ApplicationController
  before_action :set_quote, only: [:create]
  before_action :set_comment, only: [:destroy]
  
  # POST /quotes/:quote_id/comments
  def create
    @comment = @quote.comments.build(comment_params)
    
    if @comment.save
      respond_to do |format|
        format.json { 
          render json: { 
            success: true, 
            comment: comment_json(@comment),
            message: "Yorum başarıyla eklendi!"
          } 
        }
        format.html { redirect_to @quote, notice: "Yorum başarıyla eklendi!" }
      end
    else
      respond_to do |format|
        format.json { 
          render json: { 
            success: false, 
            errors: @comment.errors.full_messages 
          }, status: :unprocessable_entity 
        }
        format.html { redirect_to @quote, alert: @comment.errors.full_messages.join(", ") }
      end
    end
  end
  
  # DELETE /quotes/:quote_id/comments/:id
  def destroy
    quote = @comment.quote
    @comment.destroy
    
    respond_to do |format|
      format.json { render json: { success: true, message: "Yorum silindi!" } }
      format.html { redirect_to quote, notice: "Yorum silindi!" }
    end
  end
  
  private
  
  def set_quote
    @quote = Quote.find(params[:quote_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:content, :anonymous_name)
  end
  
  def comment_json(comment)
    {
      id: comment.id,
      content: comment.content,
      display_name: comment.display_name,
      created_at: comment.created_at.strftime("%d %B %Y, %H:%M")
    }
  end
end
