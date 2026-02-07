# CallTrack KARAHAN – Kurulum Kılavuzu

Bu kılavuz, CallTrack KARAHAN (Çağrı Takip) uygulamasının kurulumu, çalıştırılması ve program aktifken geçerli olan varsayılan ayarları açıklar. Sürüm notları ve güncellemeler için **GUNCELLEMELER.md** dosyasına bakın.

---

## 1. Gereksinimler

| Gereksinim | Açıklama |
|------------|----------|
| **İşletim Sistemi** | Windows |
| **.NET** | Ağdaki kurulum bilgisayarında **.NET 8 Runtime** yeterlidir (SDK veya proje kaynak kodu gerekmez). Publish klasörünü oluşturan makinede .NET 8 SDK gerekir. |
| **Yetki** | Windows Service kurulumu için Yönetici (Administrator) |

---

## 2. Kurulum ve Kullanım (Ağdaki Bir Bilgisayara Kurulum)

### 2.1 Tek Paket – Kurulum EXE (En Kolay, Önerilen)

**CallTrackKARAHAN_Setup.exe** tek bir dosyadır; içinde uygulama ve kurulum vardır. Kullanıcıya sadece bu dosyayı verirsiniz.

**Yapılacaklar:**

1. **CallTrackKARAHAN_Setup.exe** dosyasını hedef bilgisayara kopyalayın (USB, ağ, e‑posta vb.).
2. Dosyaya **çift tıklayın**.
3. Windows “Bu uygulama bilgisayarınızda değişiklik yapmak istiyor” diyorsa **Evet** deyin (yönetici izni).
4. Kurulum otomatik ilerler: **C:\CallTrackKARAHAN** oluşturulur, dosyalar çıkarılır, Windows servisi kurulur, tarayıcı açılır.
5. Açılan sayfada **http://localhost:5520** (veya 5521, port meşgulse) ile giriş yapın. Varsayılan kullanıcılar bölüm 3.4’te.

**Not:** Kurulum EXE tek paket olduğu için **.NET 8 Runtime** ayrıca yüklü olmasa da çalışır (paket kendi çalışma ortamını içerir). Solution veya Publish klasörü gerekmez.

**Kurulum EXE’yi nasıl üretirsiniz?**  
Proje kök dizininde (solution’ın olduğu klasörde) PowerShell ile:
```powershell
.\build-installer.ps1
```
Çıktı: `CallTrackKARAHAN.Installer\bin\SetupOutput\CallTrackKARAHAN_Setup.exe`

### 2.2 Publish Klasörü + Kurulum.bat

Publish klasörünün tamamına sahip olan kullanıcılar için:

1. **Publish** klasörünün **tüm içeriğini** hedef bilgisayara kopyalayın. Klasör adı/konumu önemli değil.
2. **Kurulum.bat** dosyasına **çift tıklayın**, yönetici izni verin.
3. Kurulum otomatik ilerler (C:\CallTrackKARAHAN, servis, tarayıcı). Giriş: **http://localhost:5520** (veya 5521, port meşgulse).

**Not:** Bu yöntemde bilgisayarda **.NET 8 Runtime** yüklü olmalıdır.

### 2.3 Manuel Kurulum (İsteğe Bağlı)

PowerShell ile kendiniz kurmak isterseniz:

**Adım 1 –** Publish içeriğini hedef bilgisayarda **C:\CallTrackKARAHAN** klasörüne kopyalayın.

**Adım 2 –** **Yönetici** olarak PowerShell açın ve:

```powershell
cd C:\CallTrackKARAHAN
.\install-service.ps1
```

**Adım 3 –** Tarayıcıda **http://localhost:5520** yazın (port değiştirdiyseniz o portu kullanın).

### 2.4 Publish Klasörünü veya Kurulum EXE’yi Kim Oluşturur?

Publish klasörü, projeyi geliştiren veya derleyen kişi tarafından **bir kez** oluşturulur. Ağdaki diğer bilgisayarlarda sadece bu hazır klasör kullanılır; o bilgisayarlarda solution açılması veya Visual Studio gerekmez.

**Kaynak kodu indirmek:** [https://github.com/scbogretmen/CallTrackKARAHAN](https://github.com/scbogretmen/CallTrackKARAHAN)

**Publish oluşturmak (sadece geliştirici/build makinesinde):**

1. Çözümü açın: `CallTrackKARAHAN.sln`
2. Proje klasörüne gidip publish alın:
   ```powershell
   cd d:\Projeler\Vestel\CallTrackKARAHAN.Web
   dotnet publish -c Release -o ..\Publish
   ```
3. **Tek paket dağıtmak için:** Proje kökünde `.\build-installer.ps1` çalıştırıp **CallTrackKARAHAN_Setup.exe** üretin; bu dosyayı dağıtın (bkz. **2.1**).  
   **Publish klasörü dağıtmak için:** Oluşan **Publish** içeriğini kopyalayıp **Kurulum.bat**’e çift tıklamalarını söyleyin (bkz. **2.2**).

---

## 3. Program Aktifken Varsayılan Ayarlar

Uygulama çalışırken aşağıdaki ayarlar varsayılan olarak geçerlidir (özel yapılandırma yapılmadığı sürece).

### 3.1 Ağ ve Erişim

| Ayar | Windows Service (Sunucu) | Geliştirme (dotnet run) |
|------|---------------------------|--------------------------|
| **Protokol** | HTTP | HTTPS |
| **Port** | 5520 (Kurulum.bat ile; meşgulse 5521) | 50201 (HTTPS), 50202 (HTTP – launchSettings) |
| **Dinlenen adres** | `http://0.0.0.0:5520` | `https://0.0.0.0:50201` |
| **Sunucudan erişim** | http://localhost:5520 | https://localhost:50201 |
| **LAN’dan erişim** | http://SUNUCU_IP:5520 | https://BILGISAYAR_IP:50201 |

**Not:** Service modunda tarayıcıda mutlaka **http://** yazın; yoksa “Bu site güvenli bağlantı sağlayamıyor” hatası alabilirsiniz.

### 3.2 Veritabanı

| Ayar | Varsayılan Değer |
|------|-------------------|
| **Tür** | SQLite |
| **Bağlantı dizesi** | `Data Source=Data\CallTrack.db` |
| **Dosya konumu** | Uygulama çalışma dizini altında `Data\CallTrack.db` |
| **Data klasörü** | Yoksa ilk çalıştırmada otomatik oluşturulur |

### 3.3 Kimlik Doğrulama ve Oturum

| Ayar | Varsayılan Değer |
|------|-------------------|
| **Şema** | Cookie Authentication |
| **Giriş sayfası** | /Auth/Login |
| **Çıkış** | /Auth/Logout |
| **Oturum süresi** | 8 saat |
| **Kayan oturum** | Açık (aktivite ile süre uzar) |

### 3.4 Varsayılan Kullanıcılar (İlk kurulumda oluşturulur)

| Kullanıcı adı | Şifre | Rol | Tam ad |
|---------------|--------|-----|--------|
| admin | Admin123! | Admin | Yönetici |
| ahmet | Ahmet123! | User | Ahmet |
| ayse | Ayse123! | User | Ayşe |
| kubra | Kubra123! | User | Kübra |
| mehmet | Mehmet123! | User | Mehmet |

**Güvenlik:** İlk girişten sonra şifreleri mutlaka değiştirin.

### 3.5 Varsayılan Çağrı Tipleri

İlk kurulumda veritabanına eklenen çağrı tipleri:

- Web  
- Telefon  
- Eposta  

### 3.6 Uygulama Yapılandırması (appsettings.json)

| Ayar | Varsayılan |
|------|------------|
| **AllowedHosts** | * (tüm hostlara izin) |
| **Logging – Default** | Information |
| **Logging – Microsoft.AspNetCore** | Warning |

### 3.7 Diğer Varsayılanlar

- **Hata sayfası (Production):** /Home/Error  
- **HSTS:** Production’da açık (Service modunda yalnızca HTTP kullanıldığı için HTTPS yönlendirmesi yapılmaz)

---

## 4. Servis Yönetimi

| İşlem | Komut (Yönetici PowerShell) |
|-------|-----------------------------|
| Servisi başlat | `Start-Service -Name CallTrackKARAHAN` |
| Servisi durdur | `Stop-Service -Name CallTrackKARAHAN` |
| Durumu kontrol et | `Get-Service -Name CallTrackKARAHAN` |
| Servisi kaldır | `cd C:\CallTrackKARAHAN` ardından `.\uninstall-service.ps1` |

Windows’ta **Hizmetler** (services.msc) üzerinden “CallTrack KARAHAN - Çağrı Takip” hizmetini de yönetebilirsiniz.

---

## 5. LAN Erişimi (Ağdan Kullanım)

Sunucuya ağ üzerinden erişmek için:

1. **Sunucu IP adresini** öğrenin: `ipconfig` → IPv4 Adresi  
2. **Windows Güvenlik Duvarı** kuralı ekleyin (Yönetici PowerShell):
   ```powershell
   New-NetFirewallRule -DisplayName "CallTrack KARAHAN Port 5520" -Direction Inbound -LocalPort 5520 -Protocol TCP -Action Allow
   ```
3. İstemci tarayıcıda: **http://SUNUCU_IP:5520**

### 5.1 Sunucu IP Adresi Değişirse – Ağdaki Diğer Bilgisayarlar Nasıl Bağlanır?

Sunucu makinesinin IP adresi değiştiğinde (örn. 192.168.1.5 → 192.168.2.5), sunucudaki tarayıcı **localhost** ile çalışmaya devam eder; ancak ağdaki diğer bilgisayarlar eski IP ile erişemez. Çözümler:

#### Önerilen: Sabit IP Kullanımı

Sunucunun IP’sinin değişmemesini sağlayın:

| Yöntem | Açıklama |
|--------|----------|
| **Yönlendiricide DHCP rezervasyonu** | Router/ modem arayüzünde sunucu bilgisayarın MAC adresine sabit IP atayın (örn. 192.168.1.100). Böylece her açılışta aynı IP verilir. |
| **Bilgisayarda statik IP** | Sunucu makinede Ağ Ayarları → IPv4’ü “Manuel” yapıp sabit IP girin. |

IP sabit kalırsa ağdaki kullanıcılar sürekli aynı adresi kullanır; bookmark ve kısayollar bozulmaz.

#### Alternatif: Bilgisayar Adı ile Erişim

IP yerine sunucu bilgisayarın adını kullanın:

```
http://SUNUCU-BILGISAYAR-ADI:5520
```

Örn. bilgisayar adı “MUHASEBE-PC” ise: `http://MUHASEBE-PC:5520`  
Bilgisayar adı: **Ayarlar → Sistem → Hakkında** veya `hostname` komutu ile öğrenilebilir.

Bu yöntem aynı ağ ve workgroup içinde çalışır; IP değişse bile adres aynı kalır. Bazı kurumsal ağlarda DNS/Bonjour olmadan çözümlemeyebilir.

#### IP Değiştiğinde Yapılacaklar

1. Sunucuda **ipconfig** ile yeni IPv4 adresini öğrenin.
2. Ağdaki kullanıcılara yeni adresi bildirin: **http://YENİ_IP:5520**
3. Tarayıcı sık kullanılanlarını ve masaüstü kısayollarını güncellemelerini isteyin.

---

## 6. Güncelleme Sonrası

Kod değişikliği veya yeni sürüm sonrası:

1. Yeniden publish edin; Publish klasörünü sunucuya kopyalayın (mevcut klasörün üzerine yazın).  
2. Sunucuda:
   ```powershell
   cd C:\CallTrackKARAHAN
   .\uninstall-service.ps1
   .\install-service.ps1
   ```

---

## 7. Sorun Giderme

### Sayfa açılmıyor / “Güvenli bağlantı sağlayamıyor” (ERR_SSL_PROTOCOL_ERROR)

- Service modunda **http://localhost:5520** kullanın (https değil).  
- Servisi yeniden başlatın: `Restart-Service -Name CallTrackKARAHAN`

### Port 50201 kullanımda

**Kurulum.bat** ile kurduysanız port zaten otomatik 50202’ye alınmış olabilir; tarayıcıda **http://localhost:50202** deneyin.

Manuel kurulum yaptıysanız veya portu sonradan değiştirmek istiyorsanız, **sadece Publish klasörüne sahipseniz** portu ortam değişkeni ile değiştirin (kod veya solution gerekmez):

1. **Yeni portu seçin** (örn. 50202, 5520 veya 50500). 1024’ün üzerinde yüksek port tercih edin; düşük portlar (1–1023) Windows’ta kısıtlı olabilir. Port boş olduğundan emin olun.
2. **Sistem ortam değişkeni ekleyin** — Yönetici PowerShell:
   ```powershell
   [Environment]::SetEnvironmentVariable("ASPNETCORE_URLS", "http://0.0.0.0:5520", "Machine")
   ```
   (Örnekte port 5520; istediğiniz portu yazın. 5520 gibi yüksek portlar önerilir.)
3. **Servisi yeniden başlatın** (ortam değişkeni servis hesabına yansısın diye):
   ```powershell
   Restart-Service -Name CallTrackKARAHAN
   ```
4. Tarayıcıda artık **http://localhost:5520** (veya seçtiğiniz port) kullanın. LAN’dan erişimde de aynı portu kullanın ve güvenlik duvarında bu portu açın (örn. `New-NetFirewallRule -DisplayName "CallTrack KARAHAN Port 5520" -Direction Inbound -LocalPort 5520 -Protocol TCP -Action Allow`).

### Veritabanı kilitli (SQLite locked)

- Aynı makinede tek bir CallTrack KARAHAN örneği çalıştığından emin olun.  
- Service’i durdurup tekrar başlatın.

### Servis kurulurken hata

- PowerShell’i **Yönetici olarak** çalıştırın.  
- Script’i **Publish klasörü içinden** çalıştırın (CallTrackKARAHAN.Web.exe ile aynı dizin).  
- `.\install-service.ps1` çalıştırma ilkesi engelliyorsa: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

---

## 8. Özet – Hızlı Başvuru

| Konu | Değer |
|------|--------|
| **Tek paket kurulum** | **CallTrackKARAHAN_Setup.exe**’ye çift tıklayın (yönetici izni verin); tek dosya, .NET gerekmez |
| **Publish + Kurulum.bat** | Publish içindeki **Kurulum.bat**’e çift tıklayın; C:\CallTrackKARAHAN oluşturulur, .NET 8 Runtime gerekir |
| Service adı | CallTrackKARAHAN |
| Görünen ad | CallTrack KARAHAN - Çağrı Takip |
| Service erişim adresi | http://localhost:5520 (port meşgulse 5521) |
| Kurulum klasörü | C:\CallTrackKARAHAN (Kurulum.bat her zaman bu klasörü oluşturup dosyaları oraya kopyalar) |
| Veritabanı dosyası | `Data\CallTrack.db` (exe yanında) |
| Varsayılan admin | admin / Admin123! |

Bu kılavuz, kurulum ve varsayılan ayarlar için tek referans olarak kullanılabilir. Özel ortamlar için `appsettings.json` ve ortam değişkenleri ile ayarlar değiştirilebilir.
