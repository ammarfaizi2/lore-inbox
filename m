Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSA3BhO>; Tue, 29 Jan 2002 20:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSA3BhG>; Tue, 29 Jan 2002 20:37:06 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:16010 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287880AbSA3Bgy>;
	Tue, 29 Jan 2002 20:36:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <garzik@havoc.gtf.org>, Stuart Young <sgy@amc.com.au>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 02:41:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org,
        Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        John Weber <weber@nyc.rr.com>
In-Reply-To: <3C5600A6.3080605@nyc.rr.com> <5.1.0.14.0.20020130113958.00a04390@mail.amc.localnet> <20020129201806.B12201@havoc.gtf.org>
In-Reply-To: <20020129201806.B12201@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VjkO-0000BM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 02:18 am, Jeff Garzik wrote:
> On Wed, Jan 30, 2002 at 12:00:11PM +1100, Stuart Young wrote:
> > Perhaps it's time we set up a specific lkml-patch mailing list, and leave 
> 
> I like the suggestion (most recently, of Daniel?  pardon if I
> miscredit) of having patches-2.[45]@vger.kernel.org type addresses,
> which would archive patches, and have a high noise-to-signal ratio.
> Maybe even filter out all non-patches.
> 
> The big issue I cannot decide upon is whether standard e-mails should be
> 	To: torvalds@
> 	CC: patches-2.4@
> or just
> 	To: patches-2.4@
> 
> (I'm guessing Linus would prefer the first, but who knows)

I'd say: cc Linus specifically if you think it's something he'd find 
personally interesting.  Leave out the cc if it's a minor bugfix or 
maintainance.

Oh, as somebody suggested in this thread, there is a difference in priority 
between bugfixes and other kinds of patches.  Should buxfixes go to 
patches-xxx@kernel.org with [BUGFIX] in the subject, or would 
bugs-xxx@kernel.org be a better idea?

> Also, something noone has mentioned is out-of-band patches.  Security fixes
> and other patches which for various reasons go straight to Linus.

Out-of-band patches are not going to stop.  The difference is, they will be 
duly noticed after the fact because they should be relatively few in 
comparison to in-band patches.

Another kind of out-of-band patch is where Linus takes the basic idea from 
somebody's patch and completely rewrites it, or does some hacking on his own, 
which he's been known to do.  Somehow I wouldn't expect he'd bother emailing 
the results to himself.

-- 
Daniel
