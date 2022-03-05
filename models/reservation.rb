# frozen_string_literal: true

Reservation = Struct.new(:id, :status, :covers, :walk_in, :start_time, :duration, :notes, :guest, :restaurant, :tables) do
  def id
    @id.presence || SecureRandom.uuid
  end

  def created_at
    Time.now
  end

  def updated_at
    Time.now
  end
end

reservation = Reservation.new(
  id:         '1',
  status:     'confirmed',
  covers:     2,
  walk_in:    false,
  start_time: Time.now,
  duration:   30,
  notes:      '',
  guest:      Guest.new(id: '1', first_name: 'John', last_name: 'Doe'),
  restaurant: Restaurant.new(id: '1', name: 'Restaurant 1', address: '123 Main St'),
  tables:     [Table.new(id: '1', number: 1, max_covers: 4)]
)
