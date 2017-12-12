require("spec_helper")

describe(Survey) do
  describe("#questions") do
    it("tells which questions are in it") do
      test_survey = Survey.create({:name => "Christmas food"})
      test_question1 = Question.create({:description => "Do you prefere somehing hot or cold to eat?", :survey_id => test_survey.id})
      test_question2 = Question.create({:description => "Do you prefere regular portion or apetizers?", :survey_id => test_survey.id})
     expect(test_survey.questions()).to(eq([test_question1, test_question2]))
    end
  end
end
