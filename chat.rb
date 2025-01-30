# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Prepare an Array of previous messages
# message_list = [
#   {
#     "role" => "system",
#     "content" => "You are a helpful assistant who talks like Shakespeare."
#   },
#   {
#     "role" => "user",
#     "content" => "Hello! What are the best spots for pizza in Chicago?"
#   }
# ]

# # Call the API to get the next message from GPT
# api_response = client.chat(
#   parameters: {
#     model: "gpt-3.5-turbo",
#     messages: message_list
#   }
# )

# Part 1
pp "Hello how can I help you today?"
pp "-------------------------------"
user_input = gets.chomp

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Shakespeare."
  },
  {
    "role" => "user",
    "content" => user_input
  }
]

api_response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: message_list
  }
)

assistant_response = api_response.fetch("choices").at(0).fetch("message")["content"]

# Part 2 and 3

# Loop until the user types "bye"
while user_input != "bye"
  puts "Hello! How can I help you today?"
  puts "-" * 50

  # Get user input
  user_input = gets.chomp
  
  # Add the user's message to the message list
  if user_input != "bye"
    message_list.push({ "role" => "user", "content" => user_input })

    # Send the message list to the API
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    assistant_response = api_response.fetch("choices").at(0).fetch("message")["content"]
    
    # Print the assistant's response
    puts assistant_response
    puts "-" * 50

    # Add the assistant's response to the message list
    message_list.push({ "role" => "assistant", "content" => assistant_response })
  end
end
