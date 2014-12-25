## TURENG-CLI

msdundar'ın [tureng betiği](https://github.com/msdundar/tureng)'ne GLI gem'i kullanarak command line arayüzü sağlamaktadır.

## Kurulum ve Kullanım

Rubygems'den indirmek için

```
$ gem install tureng-cli
```

Kaynaktan klonlayıp kullanmak için.

```
$ git clone https://github.com/alienaut/TurengCLI
$ cd tureng
$ bundle install
```

İnglizceden, türkçeye çeviri yapmak için:

```
$ tureng en ruby
O====O==============O=========O=========================================O
| ## |   Category   | English |                 Turkish                 |
O====O==============O=========O=========================================O
| 1  | Common Usage | ruby    | yakut                                   |
| 2  | General      | ruby    | bir kadın ismi                          |
| 3  | General      | ruby    | yakut rengi                             |
| 4  | General      | ruby    | lal                                     |
| 5  | General      | ruby    | kırmızı şarap                           |
| 6  | General      | ruby    | kırmızı                                 |
| 7  | Technical    | ruby    | yakut                                   |
| 8  | Technical    | ruby    | koyu kırmızı cam                        |
| 9  | Mining       | ruby    | yakut                                   |
| 10 | Places       | ruby    | güney carolina eyaletinde yerleşim yeri |
| 11 | Places       | ruby    | wisconsin eyaletinde yerleşim yeri      |
O====O==============O=========O=========================================O

```

Türkçeden, ingilizceye çeviri yapmak için:

```
$ tureng tr yakut
O====O==============O=========O===============O
| ## |   Category   | Turkish |    English    |
O====O==============O=========O===============O
| 1  | Common Usage | yakut   | ruby          |
| 2  | General      | yakut   | oriental ruby |
| 3  | General      | yakut   | carbuncle     |
| 4  | General      | yakut   | true ruby     |
| 5  | General      | yakut   | vermeil       |
| 6  | Technical    | yakut   | ruby          |
| 7  | Mining       | yakut   | ruby          |
O====O==============O=========O===============O
```

Listelenen çevirileri sınırlamak için:

```
$ tureng -l 5 en ruby
O====O==============O=========O================O
| ## |   Category   | English |    Turkish     |
O====O==============O=========O================O
| 1  | Common Usage | ruby    | yakut          |
| 2  | General      | ruby    | bir kadın ismi |
| 3  | General      | ruby    | yakut rengi    |
| 4  | General      | ruby    | lal            |
| 5  | General      | ruby    | kırmızı şarap  |
O====O==============O=========O================O
```

Diğer terimler tablosunu görüntülemek için:

```
$ tureng -f en ruby
O====O===========O==================O========================O
| ## | Category  |     English      |        Turkish         |
O====O===========O==================O========================O
| 1  | General   | oriental ruby    | yakut                  |
| 2  | General   | true ruby        | yakut                  |
| 3  | Idioms    | as red as a ruby | kıpkırmızı             |
| 4  | Idioms    | red as a ruby    | kıpkırmızı             |
| 5  | Technical | balas ruby       | açık pembe yakut       |
| 6  | Technical | balas ruby       | balas yakutu           |
| 7  | Technical | balas ruby       | lal yakut              |
| 8  | Technical | cape ruby        | capetown yakutu        |
| 9  | Technical | flash ruby       | renkli çubuk           |
| 10 | Technical | flash ruby       | rubi                   |
| 11 | Technical | pot ruby         | pota rubisi            |
| 12 | Technical | pot ruby         | pota yakutu            |
| 13 | Technical | red ruby         | kırmızı yakut          |
| 14 | Technical | ruby alumina     | kızıl alumina          |
| 15 | Technical | ruby glass       | yakut camı             |
| 16 | Technical | ruby laser       | ruby (yakut) lazeri    |
| 17 | Technical | ruby lustre      | koyu kırmızı parlaklık |
| 18 | Technical | ruby silver      | yakut gümüşü           |
| 19 | Technical | ruby spinel      | yakut spineli          |
| 20 | Technical | ruby spinel      | kaba yakut             |
| 21 | Computer  | ruby last name   | soyadı söyleyiş biçimi |
| 22 | Computer  | ruby text        | söyleniş metni         |
| 23 | Computer  | ruby-first-name  | ruby-adı               |
| 24 | Geology   | ruby silver      | pirargirit             |
O====O===========O==================O========================O

```

Yardımı ve mevcut komutları görüntülemek için:

```
$ tureng --help
```

## Bilinen Hatalar

İngilizce bir kelilme türkçe olarak arandığında hata veriyor:

```
$ tureng tr ruby
error: undefined method `css' for nil:NilClass
```

## Yapılacaklar

* Proje ruby gem'ine çevirelerek kurulum kolaylaştırılacak.
* İngilizce Readme dosyası hazırlanacak.
* Rdoc dökümantasyonu hazırlanacak

## Uyarı

Tüm kelimeler ve kelimelerin anlamları [tureng sözlükten](http://tureng.com/) çekilmektedir ve tamamı tureng sözlük veritabanlarında bulunmaktadır. Bu uygulama yalnızca konsol ortamından tureng'e erişmek isteyenlere yardımcı olmak için hazırlanmıştır. Görüntülediğiniz tüm içeriklerin yasal hakları vb. tureng'e aittir.
