# SoalShiftSISOP20_modul1_D03

Dibuat oleh:

Kelompok D03

Putu Putri Natih Devayanti (05111840000163)

Elvira Catrine Natalie (05111840000016)

### SOAL 2 
### CAESAR CIPHER
## 2a dan b 
## Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang disimpan di file
Dalam soal ini, kita diminta untuk sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan ​HANYA ​berupa alphabet​.
> Langkah dan Penjelasan
Kita generate password sepanjang 28 karakter alfanumerik dengan menggunakan perintah berikut

```
if [[ $1 =~ ^[a-zA-Z]+$ ]]
then
rdm="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true
echo $rdm > /Users/putrinatih/$1.txt
else echo "error"
fi

```

`/dev/urandom` merupakan file spesial dalam UNIX sebagai pseudo-RNG

`LC_CTYPE=C tr -dc 'a-zA-Z0-9'` membuat karakter yang dihasilkan hanyalah huruf besar, kecil, dan juga angka. Perintah ini berfungsi untuk menseleksi hasil output random dengan hanya menghasilkan karakter alfanumerik yang dengan menghapus semua karakter (`-d`) kecuali (`-c`) a-z, A-Z, dan 0-9. 

`head -c28` membuat karakter yang dihasilkan sebatas 28 karakter.

** Input file disesuaikan dengan perintah (`$1 =~ ^[a-zA-Z]+$`), dengan HANYA menggunakan alfabet. Apabila input file tidak sesuai , maka hasilnya akan error **

Perintah yang telah disebutkan diatas akan disimpan ke dalam file yang dimana setelah kita input namanya, akan disimpan sebagai argumen (`$1`) dan akan diproses.

## 2c 
## Enkripsi

Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘​bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi ​z​, akan kembali ke ​a​, contoh: huruf ​w dengan jam 5.28, maka akan menjadi huruf ​b

> Langkah dan Penjelasan

Disini kita diminta untuk melakukan enkripsi nama file sesuai dengan waktu pembuatan file tersebut saat ini. 

- Code :
```
#!/bin/bash
nama=$(echo $* | awk -F "." '{print $1}')
if [[ $1 =~ ^[A-Za-z]+$".txt" ]]; then
upper=({A..Z})
lower=({a..z})
hour=$(date +"%H")
hour1=$(($hour-1))
up1=${upper[hour]}
low1=${lower[hour]}
up2=${upper[hour1]}
low2=${lower[hour1]}
rdm="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true
encrypt="$(echo "$nama" | tr [A-Z] ["$up1"-ZA-"$up2"] | tr [a-z] ["$low1"-za-"$$
echo $rdm > "$encrypt".txt
echo "selamat! file anda telah di enkripsi!"
else
echo "Harap menggunakan Alfabet"
fi

```
`nama=$(echo $* | awk -F "." '{print $1}')` adalah untuk mengambil nama file hingga tanda titik. (indikasi .txt) Kemudian disimpan sebagai argumen (`$1`).

`if [[ $1 =~ ^[A-Za-z]+$".txt" ]]` untuk melakukan checking dalam hal penginputan file, dimana file yang diinput hanyalah dapat berupa file yang menggunakan nama berupa alfabet.

`upper=({A..Z})` dan `lower=({a..z})` adalah array huruf-huruf alfabet besar dan kecil dari a-z. 

Variabel `hour` berfungsi untuk mendapatkan nilai dari jam pembuatan file bersangkutan. Yang nantinya akan digunakan sebagai penanda dalam array sebagai penentu batasan perubahan nama file enkripsinya. 

```

hour=$(date +"%H")
hour1=$(($hour-1))
up1=${upper[hour]}
low1=${lower[hour]}
up2=${upper[hour1]}
low2=${lower[hour1]}

```

perintah diatas adalah perintah yang berguna untuk mengubah huruf semula menjadi huruf baru

`rdm="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true` merupakan penentu random value yang hanya mengeluarkan alfanumerik dengan jumlah sepanjang 28 karakter.

Variabel `encrypt` dalam `encrypt="$(echo "$nama" | tr [A-Z] ["$up1"-ZA-"$up2"] | tr [a-z] ["$low1"-za-"$$` adalah sebagai penyimpan hasil enkripsi nama file yang telah disesuaikan dengan waktu pembuatan file tsb. 

> Password random yang telah kita generate tadinya akan disimpan ke dalam file yang telah dienkripsi. 

## 2d 
## Dekripsi

Membuat dekripsinya supaya nama file bisa kembali.

> Langkah dan Penjelasan
> Code

```

#!/bin/bash
nama="$(echo $* | awk -F "." '{print $1}')"
if [[ -f $1 ]]; then
upper=({A..Z})
lower=({a..z})
hour=$(date +"%H")
hour1=$(($hour-1))
up1=${upper[hour]}
low1=${lower[hour]}
up2=${upper[hour1]}
low2=${lower[hour1]}
random="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c28)" || true
decrypt="$(echo "$nama" | tr ["$up1"-ZA-"$up2"] [A-Z] | tr ["$low1"-za-"$low2" $
mv $1 "$decrypt".txt
echo "selamat! file anda telah di dekripsi"
else
echo "file tidak ditemukan"
fi

```

Pada codingan ini, line 1-12 memiliki syntax yang sama seperti syntax pada soal2_encrypt.sh tadi. Namun, perbedaannya terletak pada perintah penyimpanan variabel yang dimana terjadi penukaran. 

`decrypt="$(echo "$nama" | tr ["$up1"-ZA-"$up2"] [A-Z] | tr ["$low1"-za-"$low2" $`, variabel disimpan dalam `decrypt`

Kemudian perintah `mv $1 "$decrypt".txt` digunakan untuk mengubah file menjadi nama semula. 

**Jika input file tidak sesuai, maka akan muncul pemberitahuan bahwa file tidak ditemukan**
