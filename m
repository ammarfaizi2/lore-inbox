Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbRE1TW0>; Mon, 28 May 2001 15:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbRE1TWQ>; Mon, 28 May 2001 15:22:16 -0400
Received: from [216.74.100.93] ([216.74.100.93]:38158 "EHLO
	host7.hrwebservices.net") by vger.kernel.org with ESMTP
	id <S263124AbRE1TWA>; Mon, 28 May 2001 15:22:00 -0400
Message-ID: <016601c0e7f7$0c7c8780$c1a5fea9@spunky>
Reply-To: <james@spunkysoftware.com>
From: <james@spunkysoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: Creative 4-speed CDROM driver
Date: Tue, 29 May 2001 05:22:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel Hackers,

Bloody Minix doesn't have a CDROM driver for my CDROM, a Creative Quad
speed. I'm dual booting between Linux and Minix. Linux uses my CDROM no
problems. I am thinking a "generic" CDROM driver might fit the bill for this
CDROM (the system is an old 486DX2/66, 20MB RAM, 500MB HDD + 300MB HDD, 1MB
Diamond Stealth Pro Video card).

Either I can port the Linux CDROM driver to Minix or I have to write my own
device driver. Can anyone help, point me to a place where hackers get the
stuff they need to write device drivers? They obviously know all the
details, like status codes, I/O regions etc. I am not sure if I would use
DMA, but I suppose it doesn't matter all that much.

If anyone on the kernel list has written a driver for a CDROM please send me
mail about how you went about it, did you approach the manufacturer for the
documentation on the device, if I made a mistake could I ruin my hardware?
and stuff like that.

Thanks heaps.
James Buchanan
james@spunkysoftware.com


