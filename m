Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSEMOLO>; Mon, 13 May 2002 10:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313731AbSEMOLN>; Mon, 13 May 2002 10:11:13 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:51086 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S313789AbSEMOLL>; Mon, 13 May 2002 10:11:11 -0400
Date: Mon, 13 May 2002 10:09:47 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: Re: More UDMA Troubles
To: linux-kernel@vger.kernel.org
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>, andre@linux-ide.org
Message-id: <001801c1faa0$fcb7cd60$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <003f01c1fa36$0106ded0$2000a8c0@metalbox>
 <20020513095630.A25699@bouton.inet6-interne.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre: This occured on 2.5.15 but I also had similar errors with 2.4.18, and
the default kernel thats installed with debian woody (I think its 2.2.17,
not sure though),  but the system still booted, it just did strange things
afterwards and eventually locked up. the 2.2.17 worked fine until I did
hdparm -c3 -d1 -X34.

Lionel: I don't want to sound like an idiot or anything but I have no idea
how to install 2.4.19-pre8, it looks like some kind of patch, but i've never
used one before.

I think that running that, hdparm command may have actually done some damage
to my computer... since then my BIOS Occasionally doesn't recognize my hard
drive, and Windows 2000 keeps getting bluescreens during the boot process,
it took 4 tries to get it to boot properly, and I ahve a feeling it will
lock up eventually. (I've never had a bluescreen uder 2000 before.)


Andre LeBlanc wrote:
> > Ok, I signed up to this list from work under the name aeleblanc, now i'm
at
> > home, so to see this history look at the other messages, anyway, i was
> > having alot of troubles getting DMA Working on my system, its a duron
1GHz
> > on an ECS Motherboard w/ an SiS Chipset. Actually, even with DMA
Disabled i
> > was getting Hard drive errors... anyway, I tried compiling 2.5.15
because i
> > was told that 2.4.19-pre8 and up had better IDE Support, but during the
boot
> > process on the new Kernel I get the following messages
>
> Please try 2.4.19-pre8. 2.5 SiS IDE driver is not yet updated.
>
> LB.

