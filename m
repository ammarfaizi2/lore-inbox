Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286400AbRL0Rzs>; Thu, 27 Dec 2001 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286403AbRL0Rzi>; Thu, 27 Dec 2001 12:55:38 -0500
Received: from ns.suse.de ([213.95.15.193]:30480 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286400AbRL0Rz2>;
	Thu, 27 Dec 2001 12:55:28 -0500
Date: Thu, 27 Dec 2001 18:55:20 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <200112271738.fBRHcSd30844@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0112271850570.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Richard Gooch wrote:

> So you just do what Linus does: delete those questions without
> replying. No matter what system you use, if you want to avoid an
> overflowing mailbox, you either have to silently drop patches, and/or
> silently drop questions/requests/begging letters. There isn't really
> much difference between the two.

just a sidenote:
Patches cc'd to linux-kernel instead of just to Alan/Marcelo/Linus are
also far more likely to be 'rediscovered' sometime, bringing up
"why wasn't this merged?" mails when perhaps the time is better for
$maintainer to merge.

I spent post-xmas-lunch going through backlogged l-k mails, and found
a bunch of patches that fix small problems that never got merged.
(These bits ended up in -dj6, and what will be -dj7 btw, and will get
pushed to the relevant people soon.)

Note however, xmas comes but once a year, so someone else can pick
up the silently ignored stuff next time 8-)

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

