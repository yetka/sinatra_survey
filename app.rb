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
  @surveys = Survey.all()
  erb(:index)
end

get ('/surveys_list') do
  @surveys = Survey.all()
  erb(:surveys_list)
end

get ('/surveys/:id/edit') do
  @survey = Survey.find(params.fetch("id").to_i())
  erb(:survey_edit)
end

patch("/survey_edit/:id") do
  name = params.fetch("name")
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.update({:name => name})
  @surveys = Survey.all()
  erb(:index)
end

delete("/survey_edit/:id") do
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.delete()
  @surveys = Survey.all()
  erb(:index)
end
