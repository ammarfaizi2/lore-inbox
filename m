Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSBFIrl>; Wed, 6 Feb 2002 03:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290309AbSBFIrc>; Wed, 6 Feb 2002 03:47:32 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:19972
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S290302AbSBFIrU>; Wed, 6 Feb 2002 03:47:20 -0500
Date: Wed, 6 Feb 2002 03:48:27 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: J Sloan <joe@tmsusa.com>
cc: linux-kernel@vger.kernel.org
Subject: SHOULD BE: 2.4.18-pre8 + 2.4.18-pre7-ac3 + rmap12c + XFS Results
In-Reply-To: <3C60E3F0.7080003@tmsusa.com>
Message-ID: <Pine.LNX.4.40.0202060347270.788-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry 2.4.18-pre7-ac3

:)

On Wed, 6 Feb 2002, J Sloan wrote:

> Great - could you compare and contrast with
> e.g. stock 2.4.17, or even 2.4.18-pre?
>
> Joe
>
> Shawn Starr wrote:
>
> >I'm happy to say that rmap12c has huge preformance improvements over
> >rmap11c with my Pentium 200Mhz w/64MB ram.
> >
> >Some of the differences:
> >
> >rmap11c: slow redrawing of mozilla, mouse hangs, system sluggishness.
> >
> >rmap12c: no slow redrawing UNLESS heavy I/O & swapping is occuring. System
> >is able to handle heavy heavy memory usage (mozilla + evolution +
> >blowup-xfs - fsx-linux.c to test XFS's stability with VM).
> >
> >Also, XFS so far is preforming without file corruption that I can see.
> >
> >a patch will be available for this shortly on my website for those who
> >want XFS + rmap12c.
> >
> >Shawn.
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
>

