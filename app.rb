require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/survey")
require("./lib/question")
require("pg")

get("/") do
  @surveys = Survey.all()
  erb(:index)
end

post('/survey_form') do
  name = params.fetch("name")
  survey = Survey.new({:name => name, :id => nil})
  survey.save()
  @test = survey.capitalize_name
  @surveys = Survey.all()
  erb(:index)
end
