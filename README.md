## Simple Serializer

Simple-serializer is a simple ruby application that serializes ruby objects, By serializing we mean the process of turning data structures into another format such as JSON

### Prerequisite

- Ruby 3.0.1

### Setup

```powershell
bin/setup
```

### Console

```powershell
bin/console
```

```ruby
guest = Guest.new('1', 'John', 'Doe')
Api::V1::GuestSerializer.new(guest).as_json # {"id"=>"1", "last_name"=>"Doe", "first_name"=>"John"}
```

```ruby
reservation =
  Reservation.new(
    '1',
    'not_confirmed',
    2,
    false,
    Time.now,
    5400,
    nil,
    Guest.new('1', 'John', 'Doe'),
    Restaurant.new('1', 'Restaurant 1', '123 Main St'),
    [Table.new('1', 1, 4)]
  )

Api::V1::ReservationSerializer.new(reservation).as_json #  "guest"=>{"id"=>"1", "last_name"=>"Doe", "first_name"=>"John"}, "restaurant"=>{"id"=>"1", "name"=>"Restaurant 1", "address"=>"123 Main St"}, "updated_at"=>"2022-03-06T23:27:21+02:00",  "created_at"=>"2022-03-06T23:27:21+02:00",  "notes"=>nil,  "duration"=>5400,  "start_time"=>"2022-03-06T23:26:37+02:00",  "walk_in"=>false,  "covers"=>2,  "status"=>"not_confirmed", {"id"=>"1","tables"=>[{"id"=>"1", "number"=>1, "max_covers"=>4}]}
```

```ruby
restaurant = Restaurant.new('1', 'The Aviary', '1313 Mockingbird Lane')
Api::V1::RestaurantSerializer.new(restaurant).as_json # {"id"=>"1", "name"=>"The Aviary", "address"=>"1313 Mockingbird Lane"}
```

```ruby
table = Table.new('1', 5, 10)
Api::V1::TableSerializer.new(table).as_json

# {"id"=>"1", "number"=>5, "max_covers"=>10}
```

### Test cases

```powershell
bundle exec rspec spec/

...............

Finished in 0.00988 seconds (files took 0.1161 seconds to load)
17 examples, 0 failures
```

### Directory Structure

```sh
├─ api
  ├─ v1
    ├─ guest_serializer.rb
    ├─ reservation_serializer.rb
    ├─ restaurant_serializer.rb
    ├─ table_serializer.rb
├─ models
  ├─ guest.rb
  ├─ reservation.rb
  ├─ restaurant.rb
  ├─ table.rb
├─ simple_serializer.rb
├─ application.rb
├─ spec
```

- **api/v1** - Serialization classes located in this path
- **application** All the application dependencies in this ruby file
- **simple_serializer** It's the base class for the project, it handles the logic to serialize or format objects all the classes in `api/v1` inherited from Simply Serializer class.
- **models** acts as AR models it initializes the Struct classes
