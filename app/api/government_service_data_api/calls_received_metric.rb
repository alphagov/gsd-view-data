class GovernmentServiceDataAPI::CallsReceivedMetric
  def self.build(data)
    new(
      total: data['total'],
      sampled: data['sampled'],
      sampled_total: data['sampled_total'],
      get_information: data['get_information'],
      chase_progress: data['chase_progress'],
      challenge_a_decision: data['challenge_a_decision'],
      other: data['other'],
    )
  end

  def initialize(total: nil, sampled: nil, sampled_total: nil, get_information: nil, chase_progress: nil, challenge_a_decision: nil, other: nil)
    @total = total
    @sampled = sampled || false
    @sampled_total = sampled_total
    @get_information = get_information
    @chase_progress = chase_progress
    @challenge_a_decision = challenge_a_decision
    @other = other
  end

  attr_reader :total, :sampled, :sampled_total, :get_information, :chase_progress,
              :challenge_a_decision, :other

  def get_information_percentage
    (@get_information.to_f / sampled_total) * 100
  end

  def chase_progress_percentage
    (@chase_progress.to_f / sampled_total) * 100
  end

  def challenge_a_decision_percentage
    (@challenge_a_decision.to_f / sampled_total) * 100
  end

  def other_percentage
    (@other.to_f / sampled_total) * 100
  end

  def is_applicable
    [@sampled_total, @get_information, @chase_progress, @challenge_a_decision, @other].compact.length.positive?
  end
end
