class HomeController < ApplicationController
  def top
    @category=Category.all
    if params[:checked]then
      if params[:checked].length-1==@category.count then

        if params[:content]
            
          @output=params[:content]
          @output=@output.gsub(/\r\n|\r|\n/, "<br>")
            
          keywords=Keyword.all
          keywords.each do |keyword|
            @output=@output.split(keyword.content)
            @output=@output.join('|'+keyword.content+'|')
          end
          @output=@output.split('|')
          


          @tests=@output
          @colors=[]#空の配列を作る
          
          @tests.each do |test| #配列を取り出してキーワードチェック

            color="black" 
            keywords.each do |keyword| #キーワードが含まれていたらred、なければblack
              boolean=test.include?(keyword.content)

                if boolean
                  color="red"
                  break;
                end
            end
            @colors.push(color)
          end
        end

      elsif params[:checked].length==1 then
        if params[:content]
            @output=[]
            @output.push(params[:content])
            @colors=[]
            @colors.push('black')
        end
        @message="チェックボックスのどれか１つ以上にチェックしてください。"
      else

        if params[:content]
            
          @output=params[:content]
          @output=@output.gsub(/\r\n|\r|\n/, "<br>")
          num=1
          while num<params[:checked].length do 
            ident=Keyword.joins(:relations).where(relations: { category_id:params[:checked][num]}).order(kana: :desc)
            ident.each do |keyword|
              @output=@output.split(keyword.content)
              @output=@output.join('|'+keyword.content+'|')
            end
            num+=1
         end

          @output=@output.split('|')
          @colors=Array.new(@output.length,"black")
          
          w=0
          while w<@output.length do 
            num=1
            while num<params[:checked].length do 
              ident=Keyword.joins(:relations).where(relations: { category_id:params[:checked][num]}).order(kana: :desc)
              ident.each do |i|
                if @output[w].include?(i.content) then
                  @colors[w]='red'
                end
              end
              num+=1
            end
            w+=1
          end


  
        end
      end
    end

        



  end





end