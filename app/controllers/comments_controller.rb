class CommentsController < ApplicationController
    before_action :set_commentable

    def new
        @comment = Comment.new
    end

    def create 
        @comment = @commentable.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            redirect_to @commentable, notice: 'comment created'
        else
            render :new
        end
    end

    def destroy 
        @comment = Comment.find(params[:id]) 
        if @comment.destroy 
            redirect_to @commentable, notice: 'comment deleted'
        else
            redirect_to @commentable, alert: 'something went wrong'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
    
    def set_commentable
        if params[:post_id].present?
            @commentable = Post.find(params[:post_id])
        elsif params[:comment_id].present?
            @commentable = Comment.find(params[:comment_id])
        end
    end 

    
end