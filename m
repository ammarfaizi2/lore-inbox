Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSIBICW>; Mon, 2 Sep 2002 04:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSIBICW>; Mon, 2 Sep 2002 04:02:22 -0400
Received: from tidos.tid.es ([193.145.240.2]:16318 "EHLO tid.tid.es")
	by vger.kernel.org with ESMTP id <S318079AbSIBICU>;
	Mon, 2 Sep 2002 04:02:20 -0400
Message-ID: <3D731C59.CA5796CF@tid.es>
Date: Mon, 02 Sep 2002 10:07:53 +0200
From: Miguel =?iso-8859-1?Q?Gonz=E1lez=20Casta=F1os?= <mgc@tid.es>
Organization: Telefonica I+D
X-Mailer: Mozilla 4.78 [es] (Windows NT 5.0; U)
X-Accept-Language: es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: recompiling kernel for a Soltek 75drv4
Content-Type: multipart/mixed;
 boundary="------------756402CA373264139D327663"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Este es un mensaje de varias partes en formato MIME.
--------------756402CA373264139D327663
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear all,

 It is my first post to this mailing list, so I am sorry for my English
and the possible mistakes that I could make. I have read through the
information of the FAQs and search a little bit but I have not found an
answer to my question, so here it goes:

 I have a Red Hat 7.2 linux box as a web server. I am still in the
proccess of tuning the system.

 It is a:
 AMD K7 Athlon
 two HD IDE 60 Gbs 
 3Com Network card
 no sound card
 general video card
 Mother board Soltek 75drv4 Chipset VT8367 KT266A

 I am compiling a non-modular kernel, due to I do not have so much
hardware and I have read that this makes the kernel faster. 

 I have executed a lspci to get the information of the mother board
shown above. I have downloaded the latest linux stable kernel 2.4.19 and
I have not found which chipset would be the best to use. 

 By the way I have created a Software RAID-1 with the two IDE hard
drives. 

 My issue is that when I try to shutdown the system I experimented two
things:

 - The system is not shutdown completely, I got a Power down message and
I got to power off the PC.

 - When I reboot the system and even when the system is shutting down, I
have seen messages from the system saying that the RAID is not properly
switched off dued to not a properly shutdowned system.

 I hope I have narrowed enough my question and give enough information
for you guys.

 Many thanks in advance

 Miguel
--------------756402CA373264139D327663
Content-Type: text/x-vcard; charset=us-ascii;
 name="mgc.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Tarjeta para Miguel González Castaños
Content-Disposition: attachment;
 filename="mgc.vcf"

begin:vcard 
n:González Castaños;Miguel
tel;work:+34 983 36 79 57
x-mozilla-html:FALSE
adr:;;;;;;
version:2.1
email;internet:mgc@tid.es
fn:Miguel González Castaños
end:vcard

--------------756402CA373264139D327663--

