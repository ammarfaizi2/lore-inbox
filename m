Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284924AbRL3U3X>; Sun, 30 Dec 2001 15:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284927AbRL3U3N>; Sun, 30 Dec 2001 15:29:13 -0500
Received: from ns.suse.de ([213.95.15.193]:62475 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284899AbRL3U3E>;
	Sun, 30 Dec 2001 15:29:04 -0500
Date: Sun, 30 Dec 2001 21:29:01 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bogus devfs ChangeLog change in 2.5.2-pre4
In-Reply-To: <200112302014.fBUKEJM29085@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0112302126010.7853-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Richard Gooch wrote:

>   Hi, Linus. Someone sneaked the appended patch into 2.5.2-pre4, which
> is not necessary and obviously wrong (the ChangeLog was correct
> previously). Please revert.
>
> Looks like the result of an automated global search-and-replace
> (i.e. lazy cleanup). Pity a sanity a last-minute sanity check wasn't
> performed by the guilty party.

dwmw2's handywork from my tree.
I read this diff a half dozen times, and given Linus' scrutiny over the
other bits I've shoved him today, I guess he overlooked it too..
Typically, I spotted it whilst merging pre4 with my tree.. Weirdness.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

