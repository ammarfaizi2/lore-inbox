Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284252AbRLEL4Z>; Wed, 5 Dec 2001 06:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284250AbRLEL4O>; Wed, 5 Dec 2001 06:56:14 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:4496 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284204AbRLEL4B>; Wed, 5 Dec 2001 06:56:01 -0500
Date: Wed, 5 Dec 2001 11:55:57 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.16 kernel panics (possible reason 2.2.2 Samba)
Message-ID: <Pine.GSO.4.33.0112051150330.11074-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux version 2.4.16	(root@linux) (gcc version 2.96 20000731	(Red Hat
>  Linux 7.0)) #4 Tue Dec 4 10:19:01 EET 2001

Please tell me you've upgraded the compiler in your stock Red Hat 7.0
distribution? The original gcc-2.96-69 is famously known to be broken,
and should not be used to compile kernels. My quick-and-dirty advice
would be to nab the "rpm" for the latest build in Red Hat 7.2
(gcc-2.96-98), upgrade it and use that to recompile the kernel.

If that's not the problem, then no doubt others will be able to help
you....

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

