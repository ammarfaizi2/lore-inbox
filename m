Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281723AbRKULUB>; Wed, 21 Nov 2001 06:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281718AbRKULTv>; Wed, 21 Nov 2001 06:19:51 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:24974 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281294AbRKULTh>; Wed, 21 Nov 2001 06:19:37 -0500
Date: Wed, 21 Nov 2001 11:19:36 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <E166VOz-0004kH-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0111211116130.795-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+", as expected.
> > CPU1 is instead labelled just "AMD Athlon(tm) Processor".
>
> Those strings are read directly out of the CPU.
> Alan

Hmmm, case of a suspicious CPU then? I haven't physically looked at it,
but all the correct XP flags (such as "sse") are reported, so it must be
the real thing.

Perhaps one is a certified MP processor, and the other (ahem) isn't...?

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

