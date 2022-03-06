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

- **lib** - lib folder contains two classes to initialize the attributes as well as associations
- **api/v1** - Serialization classes located in this path
- **application** All the application dependencies in this ruby file
- **simple_serializer** It's the base class for the project, it handles the logic to serialize or format objects all the classes in `api/v1` inherited from Simply Serializer class.
- **models** acts as AR models it initializes the Struct classes