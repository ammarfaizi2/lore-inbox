Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280634AbRKNPfl>; Wed, 14 Nov 2001 10:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280655AbRKNPde>; Wed, 14 Nov 2001 10:33:34 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:14995 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280670AbRKNPdJ>; Wed, 14 Nov 2001 10:33:09 -0500
Date: Wed, 14 Nov 2001 15:33:04 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: Matthew Sell <msell@ontimesupport.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <5.1.0.14.0.20011114090926.00a87d88@127.0.0.1>
Message-ID: <Pine.GSO.4.33.0111141529350.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just my $.02 worth on the dual Athlons...
>
> We just finished putting together what was for us a pretty big box using
> the Tyan S2460 with 1.4GHz Athlons (not MP) and ran into some troublesome
> heating problems.
>
> We put some fans into the case to circulate air around the surface of the
> board, as well as additional fans on the front and back of the case for
> additional intake/exhaust.

Well, I haven't done any temperature monitoring yet, but the case is a
monstrous Hudson rackmount chassis, with tons of space and several extra
fans, so I imagine that overheating is unlikely.

It may be hopelessly subjective, but the exhaust air from the back feels
cooler than on most of our other machines - but I know it's the CPUs
that count most.

Taking out one CPU may be an option; I'll try some other kernel options
first....

Cheers
Alastair

_____________________________________________
Alastair Stevens
MRC Biostatistics Unit
Cambridge UK
---------------------------------------------
phone - 01223 330383
email - alastair.stevens@mrc-bsu.cam.ac.uk
web - www.mrc-bsu.cam.ac.uk

