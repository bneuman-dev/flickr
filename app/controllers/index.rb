get '/' do
  # Look in app/views/index.erb
  user_id = session[:user_id]
  if user_id
    redirect to "/users/#{user_id}"
  else
    redirect to "/session/new"
  end
end

get '/users/:user_id' do
  @user = User.find(params[:user_id])
  @albums = @user.albums
  erb :profile
end

get '/albums/:album_id/photos/new' do
  @album_id = params[:album_id]
  erb :new_photo
end

post '/albums/:album_id/photos/create' do
  
  user = User.find(session[:user_id])
  album = user.albums.first

  photo_info = params["photo_file"]
  title = params["title"]
  desc = params["desc"]

  extension = photo_info[:filename].split('.')[-1]
  filename = "public/photos/user-#{user_id}-#{rand(100000)}.#{extension}" 
  temp_file = photo_info[:tempfile]
  File.open(filename, "w").write(temp_file.read)
  album.photos.create(filename: filename.split('/')[2..-1].join('/'), 
                      title: title, 
                      description: desc.strip)

  redirect '/'
 
end

get '/albums/new' do
  @user_id = session[:user_id]
  erb :new_album
end

post '/users/:user_id/create_album' do
  @user = User.find(session[:user_id])
  title = params["title"]
  desc = params["desc"]
  album = @user.albums.create(title: title, description: desc)
  redirect to "/albums/#{album.id}"
end

get '/albums/:album_id' do
  @album = Album.find(params[:album_id])
  @photos = @album.photos
  erb :album
end

get '/cookies' do
  session.inspect
end


get '/session/new' do
  if session[:user_id]
    redirect to "/"
  else
    erb :login
  end
end

post '/session/create' do
  user = User.authenticate(params[:username], params[:password])
  if user
    session[:user_id] = user.id
    redirect to "/users/#{user.id}"
  else
    redirect to "/session/new"
  end
end

get '/logout' do
  session.delete(:user_id)
  redirect to "/"
end

 # magick = MiniMagick::Image.open(filename)
  # magick.resize "48x64"
  # File.open("tmb-#{filename}", "w").write("")
  # magick.write "tmb-#{filename}"