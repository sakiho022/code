class KeywordsController < ApplicationController
  def login_form
  end
  
  def login
    if params[:id]=="edit"&& params[:password]=="github"
      session[:user_id]="edit"
      flash[:notice] = "ログインしました"
      redirect_to("/keywords/index")
    else
      # @error_messageを定義してください
      @error_message="メールアドレスまたはパスワードが間違っています"
      
      # @emailと@passwordを定義してください
      @id=params[:id]
      @password=params[:password]
      
      
      render("keywords/login_form")
    end

  end
  
  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end

  def aiueo_order
    @keywords=Keyword.all.order(kana: :asc)
  end

  def id_order
    @keywords=Keyword.all.order(id: :asc)
  end



  
  def index
    if session[:user_id]==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end
    @keywords=Keyword.all.order(id: :asc)

  end

  def create_index


    if params[:kana]
      @keyword=Keyword.new(content:params[:content],kana:params[:kana])
      @keyword.save
   else
      @keyword=Keyword.new(content:params[:content])
      @keyword.save
   end

   redirect_to('/keywords/index')

  end

  def destroy_index

    @keyword=Keyword.find_by(id:params[:id])
    @keyword.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to('/keywords/index')
  end


  
  def create_show


    if params[:kana]
      @keyword=Keyword.new(content:params[:content],kana:params[:kana])
      @keyword.save
   else
      @keyword=Keyword.new(content:params[:content])
      @keyword.save
   end

   redirect_to('/keywords/show')

  end

  def destroy_show


    @keyword=Keyword.find_by(id:params[:id])
    @relation=Relation.find_by(keyword_id:params[:id])
    @keyword.destroy
    @relation.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to('/keywords/show')
  end


  def show
    if session[:user_id]==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end

    @keywords=Keyword.all.order(kana: :asc)
  end

  def db
    if session[:user_id]==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end

    @keywords=Keyword.all.order(id: :desc).limit(5)
    @category=Category.all.order(id: :desc)
    @relation=Relation.all.order(id: :desc).limit(5)
    @boolean=params[:boolean]

    @error_message="何もされてない"
    if @boolean
      if params[:name]!=""
        if params[:kana]!=""
          if Keyword.find_by(content:params[:name],kana:params[:kana])
          find=Keyword.find_by(content:params[:name],kana:params[:kana])
            if Relation.find_by(keyword_id:find.id,category_id:params[:category])
              @error_message="用語もカテゴリーもすでに登録されています。"
            else
              new=Relation.new(keyword_id:find.id,category_id:params[:category])
              new.save
              @error_message="カテゴリーと結びつけました。"
            end
          else
            new=Keyword.new(content:params[:name],kana:params[:kana])
            new.save
            last=Keyword.last
            new=Relation.new(keyword_id:last.id,category_id:params[:category])
            new.save
            @error_message="新規ワード用語作成"
            render('keywords/db')
          end

        else 
        @error_message="読みがなを入力してください"
        render('keywords/db')
        end
      else
        if params[:kana]!=""
          @error_message="見つけたい言葉を入力してください"
        else
          @error_message="見つけたい言葉と読みがなを入力してください"
        end
      end
      
    end
  end



  def data
    @keywords=Keyword.all.order(kana: :asc)
    @category=Category.all
    @relation=Relation.all
  end

end

