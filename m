Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbRB1UK3>; Wed, 28 Feb 2001 15:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRB1UKJ>; Wed, 28 Feb 2001 15:10:09 -0500
Received: from cr793392-a.pr1.on.wave.home.com ([24.112.97.56]:4612 "EHLO
	prophit.maincube.net") by vger.kernel.org with ESMTP
	id <S129215AbRB1UKE>; Wed, 28 Feb 2001 15:10:04 -0500
From: "David Priban" <david2@maincube.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: i2o & Promise SuperTrak100
Date: Wed, 28 Feb 2001 15:11:30 -0500
Message-ID: <MPBBILLJAONHMANIJOPDAEGGFMAA.david2@maincube.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E14Xnz8-0003rQ-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Run it through ksymoops and I might be able to guess what went wrong.
>
> In theory however i2o is a standard and all i2o works alike. In
> practice i2o
> is a pseudo standard and nobody seems to interpret the spec the
> same way, the
> implementations all tend to have bugs and the hardware sometimes does too.
>
If I enable DRIVERDEBUG in i2o_core.c it makes the freeze to go away and
kernel
loads just fine. I do get bunch of I/O errors on mounted array but this may
be due to crappy HD's I'm using for testing.

David

