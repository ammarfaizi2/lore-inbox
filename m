Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280655AbRKNPkb>; Wed, 14 Nov 2001 10:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280660AbRKNPkZ>; Wed, 14 Nov 2001 10:40:25 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:28819 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280655AbRKNPjG>; Wed, 14 Nov 2001 10:39:06 -0500
Date: Wed, 14 Nov 2001 15:38:37 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <m3zo5pe5id.fsf@quimbies.gnus.org>
Message-ID: <Pine.GSO.4.33.0111141533320.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got a Tyan Tiger w/ 2x Athlon XP 1800+ running 2.2.19, and it
> works just fine.  (And compiles its kernel blindingly fast.  :-)  The
> only Tyan-related problem I've heard people having is that it's quite
> picky about what type of RAM it tolerates.  It must be registered ECC
> RAM.

Forgive me, but what does 'registered' strictly refer to? It is ECC RAM,
in a single 512Mb module, but more than that, I don't know.

But the key question is still this: is this purely a hardware issue? My
understanding is that with recent 2.4 kernels, Athlon optimisations and
AMD 760 issues are sorted - am I right?

Perhaps 2.4.15-pre4 would actually work, if I could fix the initrd
problem...? Since most -ac stuff is in there, I opted for that rather
than 2.4.13-acX for now, but maybe I should drop back to that?

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

