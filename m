Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287508AbSA0CSF>; Sat, 26 Jan 2002 21:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSA0CRz>; Sat, 26 Jan 2002 21:17:55 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:50442
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S287508AbSA0CRn>; Sat, 26 Jan 2002 21:17:43 -0500
Message-Id: <5.1.0.14.2.20020126211133.01ce7ff0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 26 Jan 2002 21:13:26 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: 2.2.20: pci-scan+natsemi & Device or resource busy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020126210522.01d433c0@whisper.qrpff.net>
In-Reply-To: <3C5344DF.6FC8BB24@mandrakesoft.com>
 <5.1.0.14.2.20020126183314.01cbb510@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:06 PM 1/26/2002 -0500, Stevie O wrote:
>At 07:07 PM 1/26/2002 -0500, Jeff Garzik wrote:
>>Stevie O wrote:
>> > My friend is trying Linux for the first time. I'm having him use the
>> > pci-scan and natsemi modules for his Netgear FA-311 card. With the initial
>>
>>These aren't Linux drivers, they are scyld.com drivers...  See
>>http://scyld.com/ for support and more info...
>
>Ahah! Thank you :P
>
>/me smacks himself for not verifying that he'd found the right drivers
>
>Any idea what drivers I *do* need?
>

Erm, wait...

A google for "linux fa-311 driver" yields this as the first result:

http://www.scyld.com/network/ethercard.html

The title of this page is "Linux Drivers for PCI Ethernet Chips"...

Netgear isn't exactly a small company, I'm finding it hard to believe that 
NOBODY has ever tried to create a module for one of their cards...


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

