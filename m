Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSEROI1>; Sat, 18 May 2002 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSEROI0>; Sat, 18 May 2002 10:08:26 -0400
Received: from pointblue.com.pl ([62.121.131.135]:55045 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S313165AbSEROI0>;
	Sat, 18 May 2002 10:08:26 -0400
Subject: ata + ide cdrom problem, off group - answers to private addr
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 May 2002 16:07:21 +0000
Message-Id: <1021738050.18067.13.camel@blizniaki.gj.pl>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Welcome!


1. i have 2x P Pro 200 MHz system on Intel EISA board. 64 MB of ram.
2. using 40 GB HD, CD writer teac on ide interface , and ultra ata pci
controller: 
(lspci):

00:02.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 05)
00:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
08)
00:09.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
00:0a.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX Memory
controller (rev 04)
00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI
bridge (rev 04)

dmesg and others on demand.

after installation of ata controller i've upgraded to 2.4.18 and my ide
cdrom wasn't detected any more. I have ide-cd compiled into kernel. 
If you need other informations write to Me at: gj@pointblue.com.pl

it's very important for me to have this cdrom running, it's teac 4x
recorder. Does not work properly on ata interface,  that's other mystery
for my because cdrom is udma compliant and ata should work with ata. 
I can say only that oTHER (tm) operating systems are working fine, this
is I can use cdrecorder.


Thx in advance.



   Grzegorz Jaskiewicz aka Kain/K4
    C/C++/PERL/PHP/SQL programmer

 

