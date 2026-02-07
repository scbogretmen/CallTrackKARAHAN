# CallTrack KARAHAN – Güncellemeler

Bu dosya, CallTrack KARAHAN (Çağrı Takip) uygulamasına yapılan güncellemeleri ve sürüm notlarını listeler.

---

## 2025-02-04

### Repository

- **GitHub:** Proje deposu [https://github.com/scbogretmen/CallTrackKARAHAN](https://github.com/scbogretmen/CallTrackKARAHAN) olarak güncellendi.

### Kurulum ve dağıtım

- **Tek paket kurulum (CallTrackKARAHAN_Setup.exe)**  
  - Tek EXE ile kurulum eklendi. Kullanıcı sadece bu dosyayı çalıştırır; .NET ayrıca gerekmez.  
  - Üretmek için proje kökünde: `.\build-installer.ps1`  
  - Çıktı: `CallTrackKARAHAN.Installer\bin\SetupOutput\CallTrackKARAHAN_Setup.exe`

- **Kurulum script’leri (Kurulum.ps1 / Kurulum.bat)**  
  - Proje nerede olursa olsun **C:\CallTrackKARAHAN** oluşturulup tüm dosyalar oraya kopyalanıyor.  
  - Varsayılan port 5520; meşgulse otomatik 5521 kullanılıyor.  
  - Manuel port değişimi için **5520** gibi yüksek port önerilir (düşük portlar 1–1023 Windows’ta kısıtlı olabilir).  
  - Güvenlik duvarı kuralı ve Windows servisi otomatik ekleniyor.  
  - Kurulum.bat çift tıklanınca yönetici izni isteniyor, kurulum tek adımda tamamlanıyor.

- **Kurulum kılavuzu (KURULUM_KILAVUZU.md)**  
  - Tek paket EXE, Publish + Kurulum.bat ve manuel kurulum adımları eklendi.  
  - Varsayılan ayarlar (port, veritabanı, kullanıcılar, çağrı tipleri) dokümante edildi.  
  - Sorun giderme ve hızlı başvuru bölümleri güncellendi.

### Uygulama

- **Service modunda HTTPS yönlendirmesi**  
  - Windows Service olarak çalışırken sadece HTTP dinlendiği için HTTPS yönlendirmesi kapatıldı.  
  - Böylece tarayıcıda **http://localhost:50201** kullanıldığında "Bu site güvenli bağlantı sağlayamıyor" (ERR_SSL_PROTOCOL_ERROR) hatası oluşmuyor.

### Marka ve arayüz

- **İsimlendirme: CallTrack KARAHAN**  
  - Uygulama adı ve görünen metinler "CallTrack MVP" yerine "CallTrack KARAHAN" olarak güncellendi.  
  - Navbar, sayfa başlıkları, login sayfası, kurulum script mesajları ve Windows servis görünen adı dahil.
- **Mehmet KARAHAN logosu**  
  - Web sayfalarının alt kısmına (footer) Mehmet KARAHAN imza logosu eklendi.  
  - Ana layout ve giriş sayfasında gösterilir.

---

## Gelecek güncellemeler

Buraya yeni tarih ve maddeler ekleyebilirsiniz. Örnek:

- **YYYY-AA-GG**
  - Değişiklik özeti.
  - İsteğe bağlı detay.
