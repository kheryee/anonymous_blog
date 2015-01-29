get '/tags' do

  erb :tags
end

get '/tags/:id' do
  @posts = Tag.find_by(name:params[:id]).posts
  erb :show_tag
end