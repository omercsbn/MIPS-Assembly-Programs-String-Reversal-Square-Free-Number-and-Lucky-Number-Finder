.data
buffer: .space 256
enkucukeleman: .word 256

input_msg: .asciiz "Sayilari girin (1 5 7 9 11 gibi): "
output_msg: .asciiz "\nOutput: The lucky number is: "
num1: .word 0
num2: .word 0
carpim: .word 0
input_num1: .asciiz "Birinci sayiyi girin: "
input_num2: .asciiz "Ikinci sayiyi girin: "
output_num1: .asciiz "\nBirinci sayi: "
output_num2: .asciiz "\nIkinci sayi: "
output_carpim: .asciiz "\nCarpimlari: "
output_esitdegil: .asciiz "\n Satir ve sutun sayisinin carpimi kadar input olmali!"
ayirici: .asciiz "\n"
array: .word 256
sayac: .word 0

.text
.globl main

main:


    # Birinci sayıyı al
    li $v0, 4
    la $a0, input_num1
    syscall

    li $v0, 5
    syscall
    sw $v0, num1

    # Ikinci sayıyı al
    li $v0, 4
    la $a0, input_num2
    syscall

    li $v0, 5
    syscall
    sw $v0, num2

    # Birinci sayıyı yazdır
    li $v0, 4
    la $a0, output_num1
    syscall

    lw $a0, num1
    li $v0, 1
    syscall

    # Ikinci sayıyı yazdır
    li $v0, 4
    la $a0, output_num2
    syscall

    lw $a0, num2
    li $v0, 1
    syscall
    
    # enteresan bir dil, temporarylere sayıları yükle.
    # daha önce sayılara temporarylerin değerini yüklemiştik.
    # sonra temporaryleri çarp ve çarpım sonucunu carpim içinde storela.

    lw $s1, num1
    lw $s2, num2
    mul $t2, $s1, $s2
    sw $t2, carpim
    
    li $v0, 4
    la $a0, output_carpim
    syscall
    
    lw $a0, carpim
    li $v0, 1
    syscall
    
    la $t5, array  # Array'in başlangıç adresi $t5 kaydediliyor     
    
    # Kullanıcıdan sayıları al
    li $v0, 4
    la $a0, input_msg
    syscall
    
    
    li $v0, 8
    la $a0, buffer
    li $a1, 256
    syscall
    


    # Toplam input sayısını bul
    la $t0, buffer
    li $t1, 0   # Toplam input sayısı

count_loop:
    lb $t2, 0($t0) # Sayıyı alıyor mu? Evet.
    

    beq $t2, '\0', adresleritut # Eğer null karaktere ulaşırsak, sonuca git
    beq $t2, 10, adresleritut
    beq $t2, ' ', sayaci_arttir  # Eğer boşluk karakterine ulaşırsak, sayacı güncelle

    #add $t3, $t3, $t2   # Yeni basamak hesaplanıyor
    
    
    
    sub $t7, $t2, 48     # '0' karakterinin ASCII değerini çıkarma
    #move $a0, $t7
    #li $v0,1
    #syscall
    
    
    li $v0, 4
    la $a0, ayirici
    syscall
    
    #bne $t6, $zero, sayiyibuyut
    li $t6, 10 # Temp 6'ya 10 yükle. Çarpım için. Basamak arttırıyor.
    mul $t3, $t3, $t6 # Temp 3'ü t6 ile çarp eğer sayı tek basamaklı ise zaten 0 olacak sonucu, ama 2. kere gelirse 0 olmayacak.
    add $t3, $t3, $t7 # Temp 3 ile temp 7'yi topla yüzler+onlar+birler vs.
    sw $t3, ($t5)        # Girilen sayı array'e yazılıyor
    
    
    lw $a0, ($t5) # Array adresini a0'a yükle
    li $v0, 1         # Ekrana yazdırma komutu.
    syscall 
    

    j siradaki_karakter
    

# bosluk gördüm, sayaç 1 artmalı!
sayaci_arttir:
    addi $t1, $t1, 1
        addi $t5, $t5, 4     # Bir sonraki array elemanına geçiliyor
        li $t3, 0           # Geçici değişken sıfırlanıyor
        li $t6, 0
            move $s4, $t1    # sayac'ın adresini $t0'a yüklemiyor artık, s4'ü arttırıyor. masmalesef. açıklaması aşağıdaydı.


# sonraki karaktere geç, sayı diyelim. 1 bitti 3, 3 bitti 5'e geç.
siradaki_karakter:
    addi $t0, $t0, 1
    j count_loop

# işim bitti ve null karakter ile karşılaştım, çıkma zamanı ve ekrana bastırma zamanı.
# fakat, başta aldığım 2 inputu düşünürsek çarpımları satır ve sütun olacak. bu ne demek? şu demek 4*3 gelirse 12 den az veya fazla input olamaz!


adresleritut:


  la $t0, array      # arrayin adresini $t0'a yükle
 

  lw $t2, ($t0)      # array'in ilk elemanını $t2'ye yükle
  
  addi $t0, $t0, 4   # $t0'daki adresi 4 artırarak bir sonraki elemanın adresine geç
  
  move $t4, $s1 # column sayısını t4'a yükle.
  
  lw $s5, num2
  lw $s6, carpim
  subi $t4, $t4, 1 # bir azalt çünkü adresi yukarda 4 arttırdın. ilk elemanı en küçük arrayine yazdın ve 2. elemana geçerek başladın.
  
  li $t6, 4
  mul $t6, $t6, $s1
  
  la $t1, enkucukeleman
  j sonucu_bastir

sonucu_bastir:

    
    bne $s6, $zero, satirgezici # Satır satır gez bakalım! t4 değeri 0 a eşit değil ise. Değilse zaten sayı kovalıyosun.
    
    
    #carpimi cagirma zamani kontrol etmek için tabii ki.
    lw $t2, carpim
    move $t1, $s4 # sayac değişkenini s4 olarak değiştir, eğer bir arraye yazıyorken başka bir arraye yazmaya kalkarsan dil kafayı yiyor. ard arda adresliyor, farklı adreslerde tutup random access yapmıyor.
    addi $t1, $t1, 1 # Son sayı için ekstra sayım yapılması gerekiyor :( $t1'i 1 başlatsaydım bu satıra ihtiyaç yoktu.
    bne $t1, $t2, esitdegiller 

    # Toplam input sayısını yazdır
    li $v0, 4
    la $a0, output_msg
    syscall
    
    la $t1, enkucukeleman        # dizi adresini yükle
    lw $t2, ($t1)        # ilk elemanı yükle
    li $t3, 0            # döngü indisi
    li $t4, 2           # dizi boyutu
    j loop
    

    # Programı bitir
    li $v0, 10
    syscall
    
# satır ve sütun sayısının çarpımı nxm input sayısına eşit değil. o nasıl olacak abla be?  
esitdegiller:
    # Ekrana eşit olmadıklarını bastır. nxm!=input_sayisi
    li $v0, 4
    la $a0, output_esitdegil
    syscall
    
    # Programı bitir
    li $v0, 10
    syscall
    

# Arrayin column sayısı kadar oku, yani her columnu ayrı ayrı oku. En küçük değeri bul, en küçük değerin adresini başka arrayde tut.
satirgezici:
	
	lw $t3, ($t0)      # arrayin sonraki elemanını yükle

	beq $t4, $zero, sonrakisatir
	blt $t3, $t2, kucugu_yukle


	beq $s6, $zero, sonucu_bastir


    	j satirsayaci
	

satirsayaci:

    subi $t4, $t4, 1
    addi $t0, $t0, 4     # Bir sonraki array elemanına geçiliyor
    addi $t9, $t9, 4
    subi $s6, $s6, 1
    j satirgezici
    
# büyük sayıyı yükle
kucugu_yukle:
    
    move $t2, $t3 # t2'ye t3'ü yükle çünkü küçük değer küçük arrayinde değişti.

    j satirgezici
    
sonrakisatir:
	beq $s6, $zero, kucugu_yukle
    move $s3, $t2 # Temp2 en küçük elemanı tutuyordu, ama artık çarpım için kullanılacak başka bir yerde store etme zamanı.

    sw $s3, ($t1) #enkucukeleman arrayine s3 değerini koy.
    
    lw $t2, ($t0)
    
    subi $t0, $t0, 4
    
    addi $t1, $t1, 4
    move $t4, $s1 # column sayısını t4'a yükle.
    j satirsayaci
    
  
loop:
    addi $t1, $t1, 4     # bir sonraki elemanın adresini yükle
    lw $t5, ($t1)        # bir sonraki elemanı yükle
    bge $t5, $t2, greater  # eğer bir sonraki eleman şimdikinden büyükse, greater'a atla
    addi $t3, $t3, 1     # döngü indisi arttır
    blt $t3, $t4, loop   # daha eleman varsa, döngüyü sürdür
    j end
greater:
    move $t2, $t5        # en büyük sayıyı güncelle
    addi $t3, $t3, 1     # döngü indisi arttır
    blt $t3, $t4, loop   # daha eleman varsa, döngüyü sürdür
end:
    li $v0, 1            # print integer system call
    move $a0, $t2        # yazdırılacak sayıyı yükle
    syscall             # sayıyı ekrana yazdır
    li $v0, 10           # exit system call
    syscall             # programı sonlandır
	



	


	
	

