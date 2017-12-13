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

get ('/question_form/:id') do
  @survey = Survey.find(params.fetch("id").to_i())
  @questions = Question.all()
  erb(:question_form)
end

post('/add_question/:id') do
  description = params.fetch("description")
  @survey = Survey.find(params.fetch("id").to_i())
  survey_id = @survey.id
  question = Question.new({:description => description, :survey_id => survey_id})
  question.save()
  @questions = Question.all()
  erb(:question_form)
end

get ('/questions/:id/edit') do
  @question = Question.find(params.fetch("id").to_i())
  erb(:question_edit)
end

patch("/question_edit/:id") do
  description = params.fetch("description")
  @question = Question.find(params.fetch("id").to_i())
  @question.update({:description => description})
  @questions = Question.all()
  @survey = Survey.find(@question.survey_id)
  erb(:question_form)
end

delete("/question_edit/:id") do
  @question = Question.find(params.fetch("id").to_i())
  @question.delete()
  @questions = Question.all()
  @survey = Survey.find(@question.survey_id)
  erb(:question_form)
end
