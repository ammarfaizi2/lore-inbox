Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTBBPoK>; Sun, 2 Feb 2003 10:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTBBPoK>; Sun, 2 Feb 2003 10:44:10 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:11537 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S265400AbTBBPoJ>; Sun, 2 Feb 2003 10:44:09 -0500
Message-ID: <001d01c2cad3$079f8440$59951ad3@windows>
From: "James Buchanan" <jamesbuch@iprimus.com.au>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
References: <5.1.0.14.0.20030203000618.00a0eb20@pop.iprimus.com.au> <3E3D3C55.2090805@pobox.com>
Subject: Re: Anyone supporting Intel 8XX chipset???
Date: Mon, 3 Feb 2003 02:52:03 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 02 Feb 2003 15:53:37.0249 (UTC) FILETIME=[3F869510:01C2CAD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, thanks.  Someone has pointed this out.  I have asked Alan something and
I
just misinterpreted what he said.

Cheers -
J

----- Original Message -----
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "James Buchanan" <jamesbuch@iprimus.com.au>
Cc: <linux-kernel@vger.kernel.org>; <alan@lxorguk.ukuu.org.uk>
Sent: Monday, February 03, 2003 2:42 AM
Subject: Re: Anyone supporting Intel 8XX chipset???


> > Is anyone writing code to directly support features of the Intel 800
series
> > chipsets?  I'm using the 8xx chipset docs from Intel to gradually
> > implement (hopefully) all the features of the 800 series of chipsets.
>
> [...]
> > One thing: should I maintain the consistency of using /dev files?
Because there
> > is a hardware random number generator in the 800 series chipsets, and I
> > am wondering whether I should export this feature as a set of functions
or
> > a /dev file.  (Both??)
>
>
> Methinks you need to find out what support already exists.
>
> The hardware RNG driver has existed for years, as has 3D support and ATA
> support...
>
> Jeff
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

