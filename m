Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSDXWQQ>; Wed, 24 Apr 2002 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312694AbSDXWQP>; Wed, 24 Apr 2002 18:16:15 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:58918 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S312691AbSDXWQP>;
	Wed, 24 Apr 2002 18:16:15 -0400
Message-ID: <003e01c1ebdd$9cbc9930$a501a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Panic at boottime
Date: Thu, 25 Apr 2002 00:15:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to use 2.5.9 on several configurations. I've used it almost
sucessfully (previous mail about initrd) on p166MMX and VMWare, but on my
desktop Duron 600 on Asus a7m-266/w 512 DDR RAM it is making oops and panic
because of attempt to kill idle task. I'm unable to get full oops output
(and decode it) because it's passing over the screen and I also can't set
serial console (it's just not working). It seems like oops happens just
before serial initialization, but I'm not sure.
Compiled kernel RPMS for i386 and SRPMS can be found at
ftp://ftp.pld.org.pl/people/adasi/
Thanx for help
WK

