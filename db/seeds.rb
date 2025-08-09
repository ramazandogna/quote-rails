# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Creating seed data for QuoteRails..."

# Create sample users
users_data = [
  {
    first_name: "Ahmet", 
    last_name: "Yılmaz", 
    linkedin_url: "https://linkedin.com/in/ahmet-yilmaz"
  },
  {
    first_name: "Zeynep", 
    last_name: "Kaya", 
    linkedin_url: "https://linkedin.com/in/zeynep-kaya"
  },
  {
    first_name: "Mehmet", 
    last_name: "Demir", 
    linkedin_url: ""
  },
  {
    first_name: "Ayşe", 
    last_name: "Şahin", 
    linkedin_url: "https://linkedin.com/in/ayse-sahin"
  },
  {
    first_name: "Can", 
    last_name: "Özkan", 
    linkedin_url: ""
  }
]

users = users_data.map do |user_data|
  User.find_or_create_by!(
    first_name: user_data[:first_name], 
    last_name: user_data[:last_name]
  ) do |user|
    user.linkedin_url = user_data[:linkedin_url]
  end
end

puts "👥 #{users.count} users created"

# Inspiring quotes
inspiring_quotes = [
  "Hayatta en büyük zafer, hiç düşmemek değil, her düştüğümüzde ayağa kalkmaktır.",
  "Başarı, hazırlık ile fırsatın buluştuğu andır. Sen her zaman hazır ol!",
  "İmkansız, sadece küçük ruhların büyük işler karşısındaki kaçışıdır.",
  "Hedeflerinizi büyük tutun ve bunları gerçekleştirmek için küçük adımlar atın.",
  "Bugün atılan her adım, yarının başarısının temeli olur.",
  "Kendine güven, evrende her şey mümkündür.",
  "Zorluklar sizi yıkmak için değil, sizi güçlendirmek için vardır.",
  "Hayallerinizin arkasından koşmaya devam edin, onlar sizi bulacaktır.",
  "Değişim acı verir, ama değişmemek daha da acı verir.",
  "Başarı, tutku ile çalışmanın sonucudur."
]

# Joke quotes
joke_quotes = [
  "Paramı biriktiriyorum dedim, karım da beni biriktiriyor artık.",
  "Evde WiFi şifresi 'çoksaygıdeğerim' oldu, hiç kimse tahmin edemiyor!",
  "Doktor: 'Sigara içiyor musunuz?' Ben: 'Bazen yutuyorum da.'",
  "İş yerinde stres yaşıyorum, eve gelince de karım var. Neyse ki çocuklar da kavga ediyor.",
  "Spor salonuna yazıldım, şimdi ayda bir gidip tartılıyorum!",
  "Markette 'Organik' yazınca fiyat da organik oluyor.",
  "Arabamı yıkadım, hemen yağmur yağdı. Meteoroloji benden danışmalı.",
  "Diyet yapıyorum: Öğle yemeğinden sonra tatlı yemiyorum... Öğle yemeğinden ÖNCE yiyorum!",
  "Telefon şarjı %1'de, ama sosyal medya enerjim %100'de.",
  "Pazarlıkta usta olmak: 100 TL'lik şeyi 95 TL'ye alıp gurur duymak."
]

# Create inspiring quotes
inspiring_quotes.each_with_index do |content, index|
  user = users[index % users.count]
  
  quote = Quote.find_or_create_by!(
    content: content,
    user: user
  ) do |q|
    q.quote_type = "inspiring"
    q.views_count = rand(50..500)
    q.likes_count = rand(5..50)
    q.dislikes_count = rand(0..10)
  end
  
  # Add some comments
  rand(1..4).times do |i|
    Comment.find_or_create_by!(
      quote: quote,
      content: [
        "Çok güzel bir söz, teşekkürler!",
        "Tam da ihtiyacım olan motivasyon.",
        "Harika, paylaşım için sağol.",
        "Bu sözü duvara asacağım!",
        "Gerçekten ilham verici."
      ].sample
    )
  end
end

puts "💫 #{inspiring_quotes.count} inspiring quotes created"

# Create joke quotes
joke_quotes.each_with_index do |content, index|
  user = users[index % users.count]
  
  quote = Quote.find_or_create_by!(
    content: content,
    user: user
  ) do |q|
    q.quote_type = "joke"
    q.views_count = rand(100..1000)
    q.likes_count = rand(10..100)
    q.dislikes_count = rand(0..5)
  end
  
  # Add some comments
  rand(1..5).times do |i|
    Comment.find_or_create_by!(
      quote: quote,
      content: [
        "Hahaha çok komik! 😂",
        "Gülmekten öldüm!",
        "Çok güzel espri, ellerine sağlık.",
        "Bu çok iyiydi! 🤣",
        "Kahkaha attım, süper!",
        "Komik ama gerçek de!",
        "Mükemmel, paylaştım bile!"
      ].sample
    )
  end
end

puts "😂 #{joke_quotes.count} joke quotes created"

# Create some votes randomly
Quote.find_each do |quote|
  # Random IP addresses for votes
  rand(5..25).times do
    ip = "192.168.1.#{rand(1..255)}"
    vote_type = rand < 0.7 ? "like" : "dislike"
    
    Vote.find_or_create_by!(
      quote: quote,
      ip_address: ip
    ) do |vote|
      vote.vote_type = vote_type
    end
  rescue ActiveRecord::RecordNotUnique
    # Skip if IP already voted for this quote
  end
end

puts "🗳️ Votes created for all quotes"

puts "\n✅ Seed data creation completed!"
puts "📊 Summary:"
puts "   Users: #{User.count}"
puts "   Quotes: #{Quote.count}"
puts "   Comments: #{Comment.count}"  
puts "   Votes: #{Vote.count}"
puts "\n🚀 Ready to launch QuoteRails!"
