Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSF1ReS>; Fri, 28 Jun 2002 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSF1ReR>; Fri, 28 Jun 2002 13:34:17 -0400
Received: from web40310.mail.yahoo.com ([66.218.78.89]:17806 "HELO
	web40310.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317063AbSF1ReR>; Fri, 28 Jun 2002 13:34:17 -0400
Message-ID: <20020628173633.10835.qmail@web40310.mail.yahoo.com>
Date: Fri, 28 Jun 2002 19:36:33 +0200 (CEST)
From: =?iso-8859-1?q?philippe=20philippe?= <philippe_aubry@yahoo.com>
Subject: Oops on a bi p3
To: linux-kernel@vger.kernel.org
Cc: philippe.aubry1@mageos.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




hello, 

I have this message when i  try to make a tar from a
big directory. This Oops 
is the same all time i try to make a tar with a big
directory, the file i try 
to compresse are on scsi disk connected by a qlogic
differential scsi card. 
It is normal?, could you give me some information.
The mother is an MSI with a VIA 694 X chipset based
with 2 p3 1Ghz.
I use a 2.4.18 kernel with smp support and different
other module.
 
Message from system :

Unable to handle kernel NULL pointer derenference at
virtual address 00000108
printing eip :
fc81797a
*pde = 00000000
Oops : 0002
CPU: 0
EIP:   0010:[<fc81797a>]         not tainted
EFLAGS: 00010002
eax: 0000fffc ebx: f7aee000 ecx: 00000010 edx:
f7aefc88
esi: f7aee020 edi: 00000108 ebp: 00000000 esp:
c02e7f18
ds: 0018 es: 0018 ss:0018
process swapper ( pid: 0, stackpage=c02e7000 )
stack : 00000001 00000001 f7aefc7c f7aefc00 00000002
00000000 24000001 
0000000b ....
Call trace : [<fc817785>] ... [<c0105000>]
Code : f3 a5 80 3b 03 75 0f 53 e8 a9 00 00 00 89 85 80
01 00 00 5b
<0>Kernel panic: Aiee, killing interrupt handler!
in interrupt handler - not syncing

philippe.aubry1@mageos.com

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
