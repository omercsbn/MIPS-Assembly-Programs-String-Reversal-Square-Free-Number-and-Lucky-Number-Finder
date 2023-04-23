.data
tamsayigir: .asciiz "Enter an integer: "
girdiginizsayi: .asciiz "Entered number: "
primelarprint: .asciiz "\nPrime divisors of this number: "
squarestring: .asciiz "\nThis number is square-free!"
notsquarestring: .asciiz "\nThis number is not square-free!"
mipste: .word 0:10   # Define an array of 20 elements and initialize all values to 0
backslash: .asciiz "\n"
.text
main:
    # Kullanıcıdan input al.
    li $v0, 4       # String yükle
    la $a0, tamsayigir  # Yüklenecek string -- tamsayigir
    syscall         # Stringi ekrana bas.

    # Kullanıcının girdiği sayıyı oku.
    li $v0, 5       # Yazılan sayıyı okumak için v0 için 5 kodunu çağır (integer).
    syscall         # Sayıyı oku.
    move $s0, $v0   # Okuduğun sayıyı s0'a yaz.
    move $s1, $v0   # Aynı sayıyı s1'e yaz. Birinde işlem yap birinde kalıcı olarak kalsın en son basacağız.

    # Girilen sayıyı ekrana bas.
    li $v0, 4       # String yükle
    la $a0, girdiginizsayi  # Yüklenecek string -- girdiginizsayi
    syscall         # Stringi ekrana bas.

    # Kullanıcının girdiği ekrana bas.
    li $v0, 1       # Integer printlemek için v0'a 1 yükle ve çağır.
    move $a0, $s0   # s0'a yazılan kullanıcı integarını a0 a yükle.
    syscall         # Ekrana bas.
    
    
    li $t4, 0        # döngünün başlangıç değerini belirle
    li $t5, 20     # döngünün sınır değerini belirle, 20 spesifik bir sayı ama yapacak bir şey yok. ilk 20 bölenini kontrol et eğer duplicate bölen varsa kare vardır.
    
    move $a0, $v0           # n değerini yükle.
    jal primeornot          # primeornot fonksiyonunu çağır.
    move $t0, $v0           # fonksiyonun dönüş değerini yükle.

    # Sonucu bastır.
    li $v0, 1       # Sayıyı bas
    move $a0, $s1   # S1'den oku ve sayıyı bas n basıyor.
    syscall         # Sayıyı printle.


    # Programdan çık.
    li $v0, 10      # Sisteme çıkış için çağrıda bulun.
    syscall # Programdan çık.


primeornot:

li $t0, 1        # i'yi 1 e eşitle. en küçük bölen 2 den başlayacak aşağıda.
add $t1, $zero, $s0    # temp1'i sayıya eşitle.
srl $t1, $t1, 1      # temp1'i sayı/2 ye eşitle çünkü yarısına kadar bölünebilirliği kontrol edeceğim.

Loop:
    # i değerini artırma işlemi
    addi $t0, $t0, 1    # i++ yap. çünkü 1 e her sayı bölünür 2 ye bölünür mü ondan kontrol etmeye başla.

    # i sayıya tam bölünüyor mu bölünmüyor mu kontrol et. tam bölenini bul arraye yaz.
    div $s0, $t0        # sayıyı i ye böl.
    mfhi $t2            # bölümden kalanı t2'ye aktar.
    bne $t2, $zero, sayiveikontrol  # kalan sıfır ise sayıyı güncelle ve kontrol etmek için zıpla. eğer i n/2'den büyük hale geldiyse artık çık.

    mflo $s0 # bölme işlemi sonucunu s0'da güncelle.

    # Sayının prime bölenlerini ekrana bas.
    li $v0, 4       # Stringi printlemek için 4 kodunu çağır.
    la $a0, primelarprint  # Stringin adresini a0'a yükle.
    syscall         # Stringi bas.

    # Sayının prime bölenlerinin sayı kısmını ekrana bas. örneğin 2 ye bölünüyorsa 2, 5 e bölünüyorsa 5.
    li $v0, 1 # integer print için 1 koduyla v0'ı çağır.
    move $a0, $t0 # t0'değerini a0'a yükle. yani tam bölen sayıyı a0'a yükle.
    syscall # ekrana integer bas.
	
    sw $t0, mipste($t4)    # arrayden al t0'a yaz.
    lw $t3, mipste($t4)   # arraye t3 ü yükle.
    
    addi $t4, $t4, 4       # adresi 4 bit arttır sonraki worde geç.
    addi $t5, $t5, -1      # döngüyü 1 azalt. infinite loopa girme.
    li $t0, 1 # i'ye 1 yükle.
    bgtz $t5, Loop       # t5 değeri 0'dan büyük olduğu sürece loopa devam et. 0 olursa çık.



sayiveikontrol:
    ble $t0, $t1, Loop   # eğer i <= n/2 den devam et loopa.


  la $t0, mipste     # arrayin adresini t0 a yükle
  addi $t1, $t0, 4    # 4 ileri git t1 e yükle sonraki elemanın adresi.

loop:
  lw $t3, ($t0)       # şu anki elemanı t3 e yükle.
  beq $t3, $zero, end # eğer eleman 0 ise looptan çık.
  lw $t4, ($t1)       # sonraki elemanın değerini t4 e yükle.
  beq $t4, $zero, end # eğer değer 0 ise looptan çık.
  beq $t3, $t4, duplicate  # eğer şu anki değer ile sonraki değer aynıysa duplicate var demektir, not square free.
  addi $t0, $t0, 4    # ilk elemana 4 ekle. sonraki adrese git.
  addi $t1, $t1, 4    # ikinci elemana 4 ekle sonraki adrese git.
  j loop              # loopa tekrar zıpla.


  
duplicate:
  li $v0, 4             # duplicate olduğunu belirtmek için bir string yazdır.
  la $a0, notsquarestring
  syscall
  li $v0, 10            # programı sonlandır.
  syscall
  
end:
  j SquareFree




SquareFree:
    li $v0, 4       # String basma kodu.
    la $a0, squarestring  # Stringin adresini yükle.
    syscall         # Stringi bastır.
    li $v0, 10            # programı sonlandır.
    syscall