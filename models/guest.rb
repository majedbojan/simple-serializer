# frozen_string_literal: true

Guest = Struct.new(:id, :first_name, :last_name) do
  def id
    self[:id] || SecureRandom.uuid
  end

  def created_at
    Time.current
  end

  def updated_at
    Time.current
  end
end
