Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313678AbSDUR5J>; Sun, 21 Apr 2002 13:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDUR5I>; Sun, 21 Apr 2002 13:57:08 -0400
Received: from bitmover.com ([192.132.92.2]:28827 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313711AbSDUR5H>;
	Sun, 21 Apr 2002 13:57:07 -0400
Date: Sun, 21 Apr 2002 10:57:06 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421105706.M10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
	Wayne Scott <wscott@work.bitmover.com>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com> <20020421133225.F4479@havoc.gtf.org> <20020421103923.I10525@work.bitmover.com> <20020421134500.A7828@havoc.gtf.org> <20020421104725.K10525@work.bitmover.com> <20020421134955.C7828@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 01:49:55PM -0400, Jeff Garzik wrote:
> I know, but graphical is useless to me...
> Give me text/plain GNU-style patches, that I can spit out without
> requiring X. :)

I did.  Install those triggers and you've got it.  Sorry to sound
uncooperative but the trigger mechanism is there to handle this, and
email notification, and automatic mirroring, and ...

So the mechanism is there, you can make the mechanism do whatever you
want.  If you check in the triggers, they will make their way into each
tree.  So do the first one and write yourself a shell script to use it.
I wouldn't check in the second one.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
