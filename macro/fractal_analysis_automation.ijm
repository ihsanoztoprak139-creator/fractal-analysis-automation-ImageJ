//====================================================================
//
// Fractal Analysis Automation for ImageJ
//
// Version : 1.0.0
//
// Developed by
// Mehmet Ihsan Oztoprak
// Department of Bioengineering
// Marmara University
//
// Description:
//
// Fully automated ImageJ macro for fractal dimension analysis
// and quantitative image preprocessing.
//
// Copyright (c) 2026 Mehmet Ihsan Oztoprak
//
//====================================================================

// --- AYARLAR ---
var sigma_degeri = 4;
var esikleme_metodu = "Otsu";

// --- KONTROLLER ---
if (nImages() == 0) { exit("Error: First you need to open an image."); }
getSelectionBounds(x, y, width, height);
if (width == 0) { exit("Error: First you need to select an area."); }

// --- KAYIT KLASÖRÜ ---
kayit_klasoru = getDirectory("Select the folder where the results will be saved.");
if (kayit_klasoru == "") { exit("The transcation has been cancelled."); }

// --- DOSYA ADI ---
orijinal_isim = getTitle();
nokta_pozisyonu = lastIndexOf(orijinal_isim, ".");
if (nokta_pozisyonu != -1) {
    uzantisiz_isim = substring(orijinal_isim, 0, nokta_pozisyonu);
} else {
    uzantisiz_isim = orijinal_isim;
}
temel_isim = uzantisiz_isim + "_ROI_x" + x + "_y" + y;

// --- İŞLEMLER ---

// Adım A, B, C (Aynı)
run("Duplicate...", "title=Fig_A_ROI");
selectWindow("Fig_A_ROI");
run("Duplicate...", "title=Fig_B_Blurred");
run("Gaussian Blur...", "sigma=" + sigma_degeri);
imageCalculator("Subtract create 32-bit", "Fig_A_ROI", "Fig_B_Blurred");
selectWindow("Result of Fig_A_ROI");
run("Add...", "value=128");
run("Enhance Contrast", "saturated=0.35");
run("8-bit");
rename("Fig_C_Subtracted");

// --- HATANIN DÜZELTİLDİĞİ YER ---

// Adım D: İkili (Binary) görüntü oluştur
selectWindow("Fig_C_Subtracted");
run("Duplicate...", "title=Fig_D_Original_Binary"); // Geçici bir isim veriyoruz
setAutoThreshold(esikleme_metodu + " dark");
run("Convert to Mask"); // Bu komut trabekülleri BEYAZ, arka planı SİYAH yapar. Bu, iskeletleştirme için doğru formattır.

// Şimdi Figür D ve Figür E'yi doğru formatlardan oluşturalım.

// Adım E: İskeletleştirme (Doğru Görüntü Üzerinde)
selectWindow("Fig_D_Original_Binary");
run("Duplicate...", "title=Fig_E_Skeleton");
run("Skeletonize"); // Beyaz trabekülleri doğru şekilde iskeletleştirir.

// Adım D: Fraktal Analiz İçin Görüntüyü Hazırla ve Yeniden Adlandır
// Fraktal analiz siyah yapıları sayar, o yüzden ters çevirmemiz lazım.
selectWindow("Fig_D_Original_Binary");
run("Invert");
rename("Fig_D_Binary_for_Fractal"); // Son halinin adını değiştiriyoruz.

// Adım F: Doğrulama görüntüsü
// İskelet (beyaz) ile orijinal ROI'yi birleştiriyoruz.
imageCalculator("Add create", "Fig_A_ROI", "Fig_E_Skeleton");
selectWindow("Result of Fig_A_ROI");
rename("Fig_F_Overlay");

// --- ANALİZ VE KAYIT ---

// Fraktal Analiz ve Log dosyasını kaydet
// SİYAH trabeküllü görüntü üzerinde yapılır.
selectWindow("Fig_D_Binary_for_Fractal");
run("Fractal Box Count...", "box=2,3,4,6,8,12,16,32,64");
selectWindow("Log");
saveAs("Text", kayit_klasoru + temel_isim + "_Fractal_Log.txt");

// İskelet Analizi ve Sonuçları Kaydet (Opsiyonel ama çok faydalı)
selectWindow("Fig_E_Skeleton");
// Analyze Skeleton zaten beyaz iskelet ister, bu yüzden Invert yapmaya GEREK YOK.
run("Analyze Skeleton (2D/3D)");
selectWindow("Results");
saveAs("Results", kayit_klasoru + temel_isim + "_Skeleton_Results.csv");


// Tüm Figürleri TIFF olarak kaydet
selectWindow("Fig_A_ROI");                      saveAs("Tiff", kayit_klasoru + temel_isim + "_A.tif");
selectWindow("Fig_B_Blurred");                  saveAs("Tiff", kayit_klasoru + temel_isim + "_B.tif");
selectWindow("Fig_C_Subtracted");               saveAs("Tiff", kayit_klasoru + temel_isim + "_C.tif");
selectWindow("Fig_D_Binary_for_Fractal");       saveAs("Tiff", kayit_klasoru + temel_isim + "_D_Fractal.tif");
selectWindow("Fig_E_Skeleton");                 saveAs("Tiff", kayit_klasoru + temel_isim + "_E_Skeleton.tif");
selectWindow("Fig_F_Overlay");                  saveAs("Tiff", kayit_klasoru + temel_isim + "_F_Overlay.tif");

// Temizlik
run("Close All");

// Sonuç mesajı
print("\\Clear");
print("Transcation completed. The results were saved to the '" + kayit_klasoru + "' folder");