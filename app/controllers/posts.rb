get '/posts' do
  erb :posts
end

get '/posts/new' do
  erb :new_post
end

post '/posts/new' do
  @tags = params[:posts][:tag].split(",").map(&:strip)
  @new_post = Post.create(title: params[:posts][:title], body: params[:posts][:body], author: params[:posts][:author])

  @tags.each do |t|
      @tag = Tag.find_or_create_by(name: t)
      @new_post.tags << @tag
  end

  redirect to "/posts/#{@new_post.id}"
end

get '/posts/:id' do
  pass if request.path_info == '/posts/new'
  @post = Post.find(params[:id])
  erb :show_post
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])

  erb :edit_post
end

patch '/posts/:id' do
  @post = Post.find(params[:id])

  @tags = params[:posts][:tag].split(",").map(&:strip)

  @post.tags.destroy_all
  @tags.each do |t|
      @tag = Tag.find_or_create_by(name: t)
      @post.tags << @tag
  end

  @post.update_attributes(title: params[:posts][:title], body: params[:posts][:body], author: params[:posts][:author])

  redirect to "/posts/#{@post.id}"
end


delete '/posts/:id' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect to '/posts'
end