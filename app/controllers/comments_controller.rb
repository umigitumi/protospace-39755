class CommentsController < ApplicationController
  def create
    #@prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.new(comment_params)
# 1.binding.pryで処理を一時停止する。５行目の下に記述。
# 以下はターミナルで操作をする。
# 2.@comment.valid?でバリデーション判定を行う。結果がfalseになることを確認する。
# 3.@comment.errors.full_messagesでエラーメッセージを確認する。
# 上記３で表示されたエラーメッセージが、テーブルへ保存できない要因となっている。
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end
end

private
def comment_params
  params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
end