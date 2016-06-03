require 'telegram/bot'
require 'dotenv'
require 'sinatra'
Dotenv.load

@owner_id = nil

def send_message_to_owner(bot, message)
  begin
    if @owner_id != nil
      bot.api.send_message(chat_id: @owner_id, text: "#{message.from.first_name}, #{message.from.last_name} : " + message.text)
    end
  rescue Exception => e
    puts e
  end
end

def handle_command_message(bot, message)
  case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/owner'
      bot.api.send_message(chat_id: message.chat.id, text: "이제부터 저에게 오는 모든 메시지는 당신에게 전송됩니다.  #{message.from.first_name} ")
      puts "#{message.from.first_name} : #{message.from.id}"
      @owner_id = message.from.id
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
  end
end

th = Thread.new do
  Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
    bot.listen do |message|
      puts message.chat.id
      puts "#{message.from.first_name} : #{message.chat.id} / #{message.text}"

      send_message_to_owner(bot, message)
      handle_command_message(bot, message)
    end
  end
end

get '/' do
  'Forward bot'
end