Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRKMRRq>; Tue, 13 Nov 2001 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277282AbRKMRRg>; Tue, 13 Nov 2001 12:17:36 -0500
Received: from ns.suse.de ([213.95.15.193]:56849 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277347AbRKMRRV>;
	Tue, 13 Nov 2001 12:17:21 -0500
Date: Tue, 13 Nov 2001 18:17:18 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <E163gpP-0001fF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0111131757140.6089-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Alan Cox wrote:

> > Well, hpa and myself are the only ones really maintaining it
> > in the last two years judging from the changelog. Some others
> > probably also contributed small changes not worthy of an entry.
> Or rewrote the Winchip code but didnt feel egotistical enough

It's not so much an ego thing imo. It's a useful pointer to find
out who changed something, and why. If nothing else, useful to
find the guilty party when something breaks 8)
/me hides*

> > I got the idea a while ago that splitting the various implementations
> > (Cyrix/K6/etc) out to seperate files would be a good start.
> I looked at that - but its hard to see the right places to split it

Agreed, it's one reason I've been putting it off until a better
time (Ie, 2.5)

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

