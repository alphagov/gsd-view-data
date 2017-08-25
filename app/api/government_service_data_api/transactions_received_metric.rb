class GovernmentServiceDataAPI::TransactionsReceivedMetric
  def self.build(data)
    new(
      total: data['total'],
      online: data['online'],
      phone: data['phone'],
      paper: data['paper'],
      face_to_face: data['face_to_face'],
      other: data['other'],
    )
  end

  def initialize(total: nil, online: nil, phone: nil, paper: nil, face_to_face: nil, other: nil)
    @total = total
    @online = online
    @phone = phone
    @paper = paper
    @face_to_face = face_to_face
    @other = other
  end

  attr_reader :total, :online, :phone, :paper, :face_to_face, :other

  def online_percentage
    (@online.to_f / total) * 100
  end

  def phone_percentage
    (@phone.to_f / total) * 100
  end

  def paper_percentage
    (@paper.to_f / total) * 100
  end

  def face_to_face_percentage
    (@face_to_face.to_f / total) * 100
  end

  def other_percentage
    (@other.to_f / total) * 100
  end

  def is_applicable
    [@online, @phone, @paper, @face_to_face, @other].compact.length.positive?
  end
end
