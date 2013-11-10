get '/' do
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  erb :event_new
end

post '/events/create' do
  @event_title = params[:title]
  @event_name = params[:organizer_name]
  @event_email = params[:organizer_email]
  @event_date = params[:date]
  @event = Event.create(title: params[:title], organizer_name: params[:organizer_name], organizer_email: params[:organizer_email], date: params[:date])
  if @event.errors.messages != {}
    @errors = @event.errors
    erb :event_new
  else
    redirect '/'
  end
end
