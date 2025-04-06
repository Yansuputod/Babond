# 📱 Onboarding Screen – Babond

## 📌 Tujuan
Fitur onboarding digunakan untuk memperkenalkan aplikasi kepada pengguna baru dengan tampilan gambar penuh (fullscreen) dan navigasi swipe. Onboarding hanya muncul saat pertama kali aplikasi dijalankan.

---

## 💠 Struktur File

```
lib/
├── features/
│   └── onboarding/
│       ├── onboarding_page.dart       # UI utama onboarding
├── core/
│   └── constants/
│       └── app_colors.dart            # Warna-warna utama aplikasi
├── main.dart                          # Entry point aplikasi
```

---

## 🎨 Desain

- **Background**: `Color(0xFFFFFDEB)` (krem lembut)
- **Gambar**: Gambar fullscreen diambil dari asset lokal
- **Tombol**:
  - Skip (pojok kiri atas)
  - Next (pojok kanan bawah)
  - Done / Let’s Go! (halaman terakhir)
- **Dots Indicator**:
  - Aktif: `AppColors.pinkDark`
  - Tidak aktif: `AppColors.pinkDark.withOpacity(0.3)`

---

## ⚖️ Logika

### Komponen Utama
- Menggunakan package `introduction_screen`
- `IntroductionScreen` digunakan untuk membuat halaman onboarding berisi `PageViewModel`
- Parameter penting:
  - `pages`: List berisi 3 `PageViewModel`
  - `onDone`: Callback saat onboarding selesai (biasanya lanjut ke halaman home)
  - `showSkipButton`, `skip`, `next`, `done`: Navigasi onboarding

### Gambar dengan Tombol
- Di halaman terakhir, ditambahkan tombol "Let's Go!" yang memanggil `onFinish`
- Gambar ditampilkan dalam `Image.asset`
- Jika `withButton` bernilai `true`, maka tombol akan muncul di tengah layar

---

## 🔢 Kode Penting

### Contoh Pemanggilan:
```dart
return IntroductionScreen(
  globalBackgroundColor: const Color.fromRGBO(255, 253, 235, 1),
  pages: [
    PageViewModel(...),
    PageViewModel(...),
    PageViewModel(
      image: _buildFullImage('assets/landing/land3.jpg', withButton: true),
      decoration: _pageDecoration(),
    ),
  ],
  onDone: onFinish,
  showSkipButton: true,
  skip: Text("Skip", ...),
  next: Icon(...),
  done: Text("Let's Go!", ...),
  dotsDecorator: DotsDecorator(...),
);
```

### Fungsi Helper:
```dart
Widget _buildFullImage(String assetPath, {bool withButton = false}) {
  if (withButton) {
    return Stack(
      fit: StackFit.expand,
      children: [...],
    );
  } else {
    return Center(child: Image.asset(assetPath));
  }
}

PageDecoration _pageDecoration() => const PageDecoration(
  titleTextStyle: TextStyle(),
  bodyTextStyle: TextStyle(),
  imagePadding: EdgeInsets.zero,
  contentMargin: EdgeInsets.zero,
  pageColor: Colors.transparent,
  bodyFlex: 0,
  imageFlex: 1,
  fullScreen: true,
);
```

---

## 🚤 Navigasi Selanjutnya
Setelah selesai onboarding:
- Fungsi `onFinish` dijalankan
- Biasanya diarahkan ke halaman utama atau login

---

## 📝 Catatan Tambahan
- Onboarding muncul sekali dengan sistem pengecekan cache/shared preferences
- Gunakan package `shared_preferences` untuk menyimpan status sudah onboarding

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();
bool? onboardingSeen = prefs.getBool("onboardingSeen");
if (onboardingSeen != true) {
  Navigator.push(...OnBoardingPage...);
  await prefs.setBool("onboardingSeen", true);
}
```

---

## 📅 Status
- [x] Selesai Implementasi UI
- [ ] Integrasi dengan Shared Preferences

