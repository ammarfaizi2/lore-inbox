Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280623AbRKNPEa>; Wed, 14 Nov 2001 10:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280627AbRKNPEK>; Wed, 14 Nov 2001 10:04:10 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:36754 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280625AbRKNPEG>; Wed, 14 Nov 2001 10:04:06 -0500
Date: Wed, 14 Nov 2001 15:04:04 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <3BF285D7.8F5AAB6E@redhat.com>
Message-ID: <Pine.GSO.4.33.0111141500350.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi folks - I'm having real problems getting our new dual CPU server
> > going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
>
> Ehm you know that XP cpu's don't support SMP configuration ?

Erm, no....

If this really is the case, then obviously my supplier doesn't know
either, as he's quite definitively stuck two of them on my mobo!
Linux happily detects two XP 1800+ CPUs on boot, but then both SMP
and UP kernels fail in this strange way. If they didn't boot at all, it
would almost be more helpful ;-)

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

