# SoalShiftSISOP20_modul1_D03

Dibuat oleh:

Kelompok D03

Putu Putri Natih Devayanti (05111840000163)

Elvira Catrine Natalie (05111840000016)

### SOAL 2
## 2a dan b. Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.
Langkah-langkahnya adalah sebagai berikut.
1. Kita generate password sepanjang 28 karakter alfanumerik dengan menggunakan perintah berikut

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

** Input file disesuaikan dengan perintah (`$1 =~ ^[a-zA-Z]+$`), dengan menggunakan alfabet. Apabila input file tidak sesuai , maka hasilnya akan error **

Perintah yang telah disebutkan diatas akan disimpan ke dalam file yang dimana setelah kita input namanya, akan disimpan sebagai argumen (`$1`) dan akan diproses.

