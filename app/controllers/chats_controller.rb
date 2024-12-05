class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users, only:[:show]

  def show
    # チャット相手のユーザーを取得
    @user = User.find(params[:id])

    # ログインユーザーが参加しているチャットルームの一覧を取得
    rooms = current_user.user_rooms.pluck(:room_id)

    # 相手のユーザーとのチャットルームが存在するか確認
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      # チャットルームが存在する場合、そのチャットルームを表示
      @room = user_rooms.room
    else
      # チャットルームが存在しない場合、新規チャットルーム作成
      @room = Room.new
      @room.save

      # チャットルームにログインユーザーと相手ユーザーを追加
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id:@user.id, room_id: @room.id)
    end

    # チャットルームに関連づけられたメッセージを取得
    @chats = @room.chats

    # 新しいメッセージを作成するためのからのChatオブジェクトを生成
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    # フォームから送信されたメッセージを取得して、ログインユーザーに関連づけて保存
    @chat = current_user.chats.new(chat_params)

    # バリデーションに合格しない場合はエラーを表示
    if @chat.save
      render :create
    else
      render :validater
    end
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end
  
  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  # 関連のないユーザーをブロックする
  def block_non_related_users
    user = User.find(params[:id])
    unless current_user.is_followed_by?(user) && user.is_followed_by?(current_user)
      redirect_path users_path(user)
    end
  end

end
