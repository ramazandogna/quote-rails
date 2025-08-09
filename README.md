# Quote Rails

Bu proje, kullanıcıların komik ve ilham verici alıntıları paylaşabileceği basit bir Ruby on Rails uygulamasıdır.

## Özellikler

- **Alıntı Paylaşımı**: Kullanıcılar komik veya ilham verici alıntılar paylaşabilir
- **Kategoriler**: Alıntılar "joke" (komik) veya "inspiring" (ilham verici) olarak kategorilere ayrılır
- **Oylama Sistemi**: Kullanıcılar alıntıları beğenebilir veya beğenmeyebilir
- **Yorum Sistemi**: Her alıntıya yorum yapılabilir
- **Görüntülenme Sayacı**: Her alıntının kaç kez görüntülendiği takip edilir
- **Rastgele Alıntılar**: Rastgele alıntı keşfetme özelliği

## Teknolojiler

- Ruby on Rails 8.0+
- SQLite3 (geliştirme ortamı)
- Tailwind CSS
- Turbo & Stimulus (Hotwire)

## Kurulum

1. Repoyu klonlayın:
```bash
git clone https://github.com/ramazandogna/quote-rails.git
cd quote-rails
```

2. Gerekli gem'leri yükleyin:
```bash
bundle install
```

3. Veritabanını oluşturun ve migrate edin:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Uygulamayı çalıştırın:
```bash
rails server
```

Uygulama `http://localhost:3000` adresinde çalışacaktır.

## Proje Yapısı

- **Models**: User, Quote, Comment, Vote
- **Controllers**: Quotes, Users, Comments için CRUD operasyonları
- **Views**: Responsive tasarım ile Tailwind CSS kullanımı
- **Routes**: RESTful API yapısı

## Lisans

Bu proje özel bir lisans altında lisanslanmıştır. Lisans detayları için `LICENSE` dosyasına bakınız.

**İzin Verilen Kullanımlar:**
- Kaynak kodu eğitim amaçlı incelemek ve öğrenmek
- Uygulamayı yerel olarak test etmek
- Bug report ve özellik önerileri göndermek
- Pull request ile katkıda bulunmak

**Yasak Kullanımlar:**
- Ticari kullanım
- Değiştirilmiş versiyonları yeniden dağıtmak
- Uygulamayı izinsiz public olarak host etmek
- Kodları rakip ürün geliştirmek için kullanmak

**Önemli**: İzin alınmadan bu projenin fork edilip dağıtılması, değiştirilerek yayınlanması kesinlikle yasaktır.

## Geliştirici

**Ramazan Doğna**

- Website: [ramazandogna.com](https://ramazandogna.com)
- GitHub: [github.com/ramazandogna](https://github.com/ramazandogna)
- LinkedIn: [linkedin.com/in/ramazandogna](https://www.linkedin.com/in/ramazandogna/)

---
© 2025 Ramazan Doğna. Tüm hakları saklıdır.
