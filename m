Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284711AbRL2LKm>; Sat, 29 Dec 2001 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287182AbRL2LKd>; Sat, 29 Dec 2001 06:10:33 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:9761 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S284711AbRL2LKV>;
	Sat, 29 Dec 2001 06:10:21 -0500
Message-ID: <009801c19059$754aa5c0$d500a8c0@mshome.net>
From: "Astinus" <Astinus@netcabo.pt>
To: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011229042139.GC14067@thune.mrc-home.com> <9467.1009601050@ocs3.intra.ocs.com.au> <20011229025229.A2103@conectiva.com.br>
Subject: =?iso-8859-1?Q?PORTUGU=EAs_EM=3F=3F?=
Date: Sat, 29 Dec 2001 11:10:41 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Dec 2001 11:08:40.0272 (UTC) FILETIME=[2BB2ED00:01C19059]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ola, estava a descarregar os meus e-mails da Kernel mailing list e nao pude
deixar de repara no teu nome Português !!!!
E sempre bom saber que ha portugueses nestas andanças e dispostos a ajudar.

Bem eu tenho dois problemas que quanto a mim serao bastante simples de tu os
solucinares !!!

o 1º e so seguinte:

Eu tenho tido uns problemazitos com os meus controladores usb que jah
resolvi, e portanto consegui recente-mente que o meu kernel detecta-se a
minha unidade de gravação HP8200e.
O aparelho aparece nos scsi devices como devia!!
No entanto eu nao sei a que ficheiro do sistema é que ele está designado....
( sda1 sda2....... ) ou outro qq.
Gostava que medisses como e que isso se descorbre, uma vez que nap aparece
nada do fstab jah que quando instalei o red hat 7.2 de opri9gem ele naop me
r~econheceu as saidas usb, o que so aconteceu numa compilação posteriror do
kernel.

o 2º problema e o seguinte!!!!!

Eu estou a pensar em comprar um computador novo. E o setup que tenho pensado
é o seguinte:

Mother Board D850GB AL 46800
Processador Intel P4 1,8 GHz 70800
Disco Rígido Seagate Cheeta 4Mb Cache 10.000 Rpm 32 Gigas 110400 (queria o
de 73 gigas e 16 mb cache mas 300 contos nao dah para mim)
Controlodor SCSI Adaptec SCSI Ultra 160  99000
Placa de Vídeo Matrox G450  22800
Memória Ram 1 GHz 119520 ( 2 rims de 512 isso explica o presso a gb so
trabalha com rims)
Drive de Diskettes Drive 3.5 3000
Cd-Rom 52x Creative 52x 8640
Caixa do PC P4 Tower + Cooling 44160 ( o cooling adicional sao duas
ventoinhas de 11 cm de diametro ligadas directamente a 22~0volts)
Total  525120

( preços sem iva e em escudos )

E eu ecrevi um setup semelhante numa msg qu emandei a outros gajo e todo
eles me disseram para investir em athlon que o que se poupa n ram e no
processador e na ~board dah para investir em outras cenas!!!!!!

A minha per gunta e a seguinte:

Se eu investir em Athlon 1.8 GHz por exemplo, que board e que escolho??? Nao
gosto das Asus tec ( ate podem ser boas mas nao gosto delas ).
Para o pentium era simples INTEL e pronto mas e para AMD?? Qual e a boarde
de QUALIDADE e que tenha uma assistencia convincente???

Jah agora mais uma coisa, nas diuversas respostas que me deram acerca deste
tema disseram -me o seguinte:
"
 Ram => 1000 mb ram 2x 512 rims

That is an unfortunate amount of RAM. Rather than forcing everyone
to run their OS the same way, Linux lets people with smaller amounts
of memory avoid the overhead needed to handle large amounts of memory.
There are 3 configs:

2 MB to 896 MB  (fastest)
up to 2 or 4 GB (upper limit depends on your motherboard)
up to nearly 64 GB (slowest)

As you can see, 1 GB is just barely into the second config.
You might consider instead 512 MB, 768 MB, 1.5 GB, or 2 GB."


E SOBRE O CHIPSET O SEGUINTE:"Don't get a VIA motherboard. Linux 2.4.17 has
workarounds for
the two most serious problems, but still... VIA tried very hard
to hide the problems, even blaming Creative Labs for a while


