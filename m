Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSIVKaJ>; Sun, 22 Sep 2002 06:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263286AbSIVKaJ>; Sun, 22 Sep 2002 06:30:09 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:17986 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S262783AbSIVKaI>;
	Sun, 22 Sep 2002 06:30:08 -0400
Message-ID: <000a01c26223$90b2ce90$0201a8c0@witek>
From: "Witek Krecicki" <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209221225180.3713-100000@ep09.kernel.pl>
Subject: Re: [2.5.38] IDE oopses on vmware
Date: Sun, 22 Sep 2002 12:33:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Witek Krecicki" <adasi@kernel.pl>
> Oops happens after:
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
> hda: VMware Virtual IDE Hard Drive, ATA DISK drive
> hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
> ide2: ports already in use, skipping probe
{cut}
Just checked: the same oops happens on 'physical' Asus A7M266

--
* Witek Krecicki   adasi@pld.org.pl adasi@kernel.pl  GG346981 +48502117580 *
* "None but ourselves can free our minds"  -  Bob Marley,  Redemption Song *
* http://www.risingsun.org  http://www.kernel.org    http://www.pld.org.pl *
* http://risingsun.eu.org    http://www.6bone.pl    http://www.amnesty.org *



