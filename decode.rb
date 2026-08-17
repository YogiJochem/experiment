require 'json'

# --- 1. DEFINE MISSING GAME CLASSES ---
# We define empty dummy classes so Marshal doesn't panic when it sees them.
# If you get another "undefined class/module X", just add `class X; end` here!
class MonDataHash < Hash; end
class MonWrapper; end
class MonData; end
class TeamData; end
class TrainerWrapper; end
class PokeBattle_Trainer; end

# --- 2. GENERIC CONVERSION HELPER ---
def object_to_hash(obj, visited = {})
  # Return basic types immediately
  if obj.nil? || obj.is_a?(String) || obj.is_a?(Numeric) || obj.is_a?(TrueClass) || obj.is_a?(FalseClass)
    return obj
  elsif obj.is_a?(Symbol)
    return obj.to_s
  end

  # Check for circular references to prevent crashes
  obj_id = obj.object_id
  if visited[obj_id]
    return "[Circular Reference: #{obj.class.name}]"
  end
  visited[obj_id] = true

  # Process Hashes (including our custom MonDataHash)
  if obj.is_a?(Hash) || obj.class.ancestors.include?(Hash)
    new_hash = {}
    obj.each { |k, v| new_hash[k.to_s] = object_to_hash(v, visited) }
    new_hash
  # Process Arrays
  elsif obj.is_a?(Array)
    obj.map { |v| object_to_hash(v, visited) }
  # Process ANY custom class that has instance variables (like TeamData, MonData, etc.)
  elsif !obj.instance_variables.empty?
    vars = { "_class_name" => obj.class.name } # Helps you identify the object type in the JSON
    obj.instance_variables.each do |var|
      key = var.to_s.sub('@', '')
      vars[key] = object_to_hash(obj.instance_variable_get(var), visited)
    end
    vars
  # Fallback
  else
    obj.to_s
  end
end

file_path = 'trainers.dat' # Make sure this matches your file name

begin
  # --- 3. READ AND DECODE ---
  raw_data = File.binread(file_path)
  
  puts "Decoding Marshal data..."
  decoded_data = Marshal.load(raw_data)
  
  puts "Converting game objects to readable format (this might take a moment)..."
  readable_data = object_to_hash(decoded_data)
  
  # --- 4. EXPORT TO JSON ---
  output_file = 'decoded_trainers.json'
  File.write(output_file, JSON.pretty_generate(readable_data))
  
  puts "Success! Data has been extracted to '#{output_file}'."
  
rescue TypeError, ArgumentError => e
  puts "Deserialization Error: #{e.message}"
  puts "You might be missing another class definition. Add 'class ClassName; end' to the top of the script."
rescue => e
  puts "An unexpected error occurred: #{e.message}"
end