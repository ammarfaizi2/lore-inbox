Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSEMTLD>; Mon, 13 May 2002 15:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSEMTLC>; Mon, 13 May 2002 15:11:02 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:56009 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S314351AbSEMTK4>; Mon, 13 May 2002 15:10:56 -0400
Date: Mon, 13 May 2002 15:09:28 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: 2.4.19-pre8, network connection disapperead (was: More UDMA Troubles)
To: linux-kernel@vger.kernel.org
Message-id: <007501c1faca$da37eac0$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed kernel 2.4.19-pre8 in hopes of getting UDMA Working on my debian
installation, i still see some wierd errors fly by on the boot up, but i
can't figure out what they say :)  i tried to apt-get install hdparm but my
network connection disappeared, the ethernet card is still detected, but i
can't even ping my firewall, I see some DHCP Errors go by, i think one of
them mentions dhclient.pid but again, they go by too fast and I can't read
them... I compiled the right driver for my ethernet card so I don't know
what else i could have changed, If I boot the 2.2.20 kernel it works fine.

oh, and in 2.4.19-pre8 something is wrong with ioapic.c, the compilation
broke there. i just took it out of the kernle config and it worked fine.

Andre

