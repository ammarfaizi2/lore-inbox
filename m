Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315467AbSEMCBe>; Sun, 12 May 2002 22:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSEMCBd>; Sun, 12 May 2002 22:01:33 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:27390 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S315467AbSEMCBc>; Sun, 12 May 2002 22:01:32 -0400
Date: Sun, 12 May 2002 21:23:58 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: More UDMA Troubles
To: linux-kernel@vger.kernel.org
Message-id: <003f01c1fa36$0106ded0$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I signed up to this list from work under the name aeleblanc, now i'm at
home, so to see this history look at the other messages, anyway, i was
having alot of troubles getting DMA Working on my system, its a duron 1GHz
on an ECS Motherboard w/ an SiS Chipset. Actually, even with DMA Disabled i
was getting Hard drive errors... anyway, I tried compiling 2.5.15 because i
was told that 2.4.19-pre8 and up had better IDE Support, but during the boot
process on the new Kernel I get the following messages

hda: dma_intr: error=0x84 {DriveStatusError BadCRC }
hda: recalibrating!
{ dma_intr }
hda: dma_intr: error=0x84 {DriveStatusError BadCRC }
{ dma_intr }
hdb: DMA Disabled

then the system Locks solid.

can anyone help me with this, this is the third kernel I've tried and
they've all had very serisous problems.


