# SoalShiftSISOP20_modul1_D03

Dibuat oleh:

Kelompok D03

Putu Putri Natih Devayanti (05111840000163)

Elvira Catrine Natalie (05111840000016)


## SOAL 1

**a. Menentukan Region dengan Profit Minimum dari Semua Region**

> Langkah dan Penjelasan

Code: 
```

echo "Soal 1: "
a=$(awk -F"\t" 'NR > 1 {Data[$13] += $21} END { for (i in Data) print Data[i],i }' /Users/putrinatih/Downloads/Sample-Superstore.tsv | sort -g | head -1)
echo "$a"

```

- `awk -F "\t"`  untuk mengubah field separator menjadi tab

- `NR > 1` untuk melakukan proses setelah baris 1 karena baris 1 adalah penamaan kolom

- `Data[$13] += $21` menjumlahkan nilai profit berdasarkan kolom regionnya

- `for (i in Data) print Data[i],i` looping untuk akumulasi dan sebagai output

- `sort -g` mengurutkan hasil yang didapatkan secara ascending

- `head -1` mendapatkan hasil urutan teratas (minimum)


**b. Menentukan 2 State dengan Profit Minimum berdasarkan hasil 1 a**

Code
```

echo "Soal 2: "
b=$(awk -F"\t" 'NR > 1 {if ($13 == "Central") {Reg[$11] += $21}} END { for (i in Reg) print Reg[i],i }' /Users/putrinatih/Downloads/Sample-Superstore.tsv | sort -g | head -2)
echo "$b"

```

> memiliki syntax mirip seperti soal no.1 

- `if ($13 == "Central")` adalah inisiasi kolom state berdasarkan region yang telah didapat pada 1 a, yaitu central

- `Reg[$11] += $21` untuk menjumlahkan nilai profit berdasarkan kolom state

- `for (i in Reg) print Reg[i],i` akumulasi profit dan output

- `sort -g` untuk mengurutkan hasil yang didapat secara ascending

- `head -2` untuk mendapatkan hasil 2 urutan teratas

**c. Menentukan 10 Product Name dengan Profit Minimum berdasarkan hasil 1 b**

Code
```

echo "Soal 3: "
c=$(awk -F"\t" 'NR > 1 {if ($13 == "Central") {if ($11 == "Texas" || $11 == "Illinois") {Data[$17] += $21} } } END { for (i in Data) print Data[i],i }' /Users/putrinatih/Downloads/Sample-Superstore.tsv | sort -g | head -10)
echo "$c"

```
> memiliki syntax mirip seperti soal no.1b

`if($11 == "Texas" || $11 == "Illinois")` untuk menentukan kolom product name berdasarkan state yang telah didapat pada 1 b, yaitu Texas dan Illinois

`Data[$17] += $21` untuk menjumlahkan nilai profit berdasarkan kolom `product name`

`for (i in Data) print Data[i],i` akumulasi data dan output

`sort -g` mengurutkan hasil yang didapat secara ascending

`head -10` mendapatkan hasil 10 urutan teratas


## SOAL 2 
## CAESAR CIPHER
### 2a dan b 
### Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang disimpan di file

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

### 2c 
### Enkripsi

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
encrypt="$(echo "$nama" | tr [A-Z] ["$up1"-ZA-"$up2"] | tr [a-z] ["$low1"-za-"$low2"])"
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

### 2d 
### Dekripsi

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
decrypt="$(echo "$nama" | tr ["$up1"-ZA-"$up2"] [A-Z] | tr ["$low1"-za-"$low2" [a-z]])"
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


## SOAL 3

### 3a

Mendownload 28 gambar dari link yang sudah tersedia dengan fungsi wget dan mengubah nama filenya dengan fungsi -0

```

#!/bin/bash
for i in {1..28}
do
wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a wget.log
done

```

- Kita gunakan -a untuk menambahkan lalu -0 untuk mengubah nama file menjadi “pdkt_kusuma_$i” dimana maksud dari $i adalah penomoran (iterasi) -> `sebanyak 28 gambar` saat mendownload gambar. 
- Menggunakan fungsi wget untuk langsung mendownload file yang ada di website dan wget.log untuk menyimpan file yang sudah didownload

### 3b

Script download hanya berjalan setiap 8 jam dimulai dari pukul 6.05 setiap hari kecuali hari Sabtu, maka dibuat cron job sebagai berikut

```

crontab -e

5 6-23/8 * * 0-5 /home/<user>/soal3.sh

```

`5 6-23/8 * * 0-5`
- 5 adalah menit ke-5
- 6-23/8 adalah setiap 8 jam dari pukul 06.00-23.00
- 0-5 adalah hari minggu - jumat (setiap hari kecuali hari sabtu)

### 3c


