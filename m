Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSEHFbM>; Wed, 8 May 2002 01:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSEHFbL>; Wed, 8 May 2002 01:31:11 -0400
Received: from [203.199.93.15] ([203.199.93.15]:45572 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S315528AbSEHFbK>; Wed, 8 May 2002 01:31:10 -0400
From: "pavankvk" <pavankvk@indiatimes.com>
Message-Id: <200205080509.KAA29799@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "pavankvk" <pavankvk@indiatimes.com>
Subject: Unable to handle kernel paging request problem at shutdown on 2.2.12
Date: Wed, 08 May 2002 10:56:49 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello folks

i recently installed a redhat ditribution 6.2(Linux kernel2.2.12)
my hardware is cyrix 233 with 32megs of RAM.

everything went fine during installation.the system is running fine to my knowledge.
The problem is with complete shutdown.when i give init 0 command,everything succeeded and the system is halted.But instead of getting a powerdown message finally, i got a error as below :

Unable to handle kernel paging request at virtual address ffffa00a 
00007598 
*pde = 00001063 
Oops: 0000 
CPU: 0 
EIP: 0068:[<00007598>] Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386 
EFLAGS: 00210086 
eax: 000022ff ebx: 00806b06 ecx: 00000070 edx: 00000000 
esi: 0000000a edi: 00200000 ebp: c6f87737 esp: c6f83eb0 
ds: 0080 es: 0078 ss: 0018 
Process cat (pid: 8454, stackpage=c6f83000) 
Stack: 000a0002 00800000 00060078 7741757a 00000000 687a0070 6b1f3ee4 00180000 
       02460018 69740042 00960078 cb4c6000 0060000b 00000042 00800078 00000070 
       00000000 c01d3956 00000010 00200046 00000000 00200000 d0aa0018 c0110018 
Call Trace: [<c01d3956>] [<c0110018>] [<c01d39ac>] [<c01d402f>] [<c014ed1a>] 
   [<c0130ec6>] [<c0106b1b>] 


i had previously a windows 95 with harddisk partioned.i just formatted the hard drives before installing linux thru a bootable cdrom.my BIOS is Award BIOS.
Please help me out

Thanks
pavan


Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

