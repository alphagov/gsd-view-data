class GovernmentServiceDataAPI::TransactionsWithOutcomeMetric
  def self.build(data)
    new(
      count: data['total'],
      count_with_intended_outcome: data['with_intended_outcome'],
    )
  end

  def initialize(count: nil, count_with_intended_outcome: nil)
    @count = count || 0
    @count_with_intended_outcome = count_with_intended_outcome
  end

  attr_reader :count, :count_with_intended_outcome

  def with_intended_outcome_percentage
    (@count_with_intended_outcome.to_f / @count) * 100
  end

  def is_applicable
    [@count, @count_with_intended_outcome].compact.length.positive?
  end
end
