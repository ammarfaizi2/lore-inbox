Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSDURr1>; Sun, 21 Apr 2002 13:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDURr0>; Sun, 21 Apr 2002 13:47:26 -0400
Received: from bitmover.com ([192.132.92.2]:20123 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313660AbSDURrZ>;
	Sun, 21 Apr 2002 13:47:25 -0400
Date: Sun, 21 Apr 2002 10:47:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421104725.K10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
	Wayne Scott <wscott@work.bitmover.com>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com> <20020421133225.F4479@havoc.gtf.org> <20020421103923.I10525@work.bitmover.com> <20020421134500.A7828@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Gnifty... I don't know that I would ever use the multiple-undo stack,
> but being able to see a single GNU-style patch for set of "what I just
> downloaded in the last bk pull" would definitely come in handy.

We have a graphical version of that already, sort of, do a "bk csets"
after doing a pull.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
