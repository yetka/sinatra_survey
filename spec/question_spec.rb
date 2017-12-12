require("spec_helper")

describe(Question) do
  describe("#survey") do
    it("tells which survey it belongs to") do
      test_survey = Survey.create({:name => "Christmas food"})
      test_question = Question.create({:description => "Do you prefere somehing hot or cold to eat?", :survey_id => test_survey.id})
      expect(test_question.survey()).to(eq(test_survey))
    end
  end
end
