Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbSJESga>; Sat, 5 Oct 2002 14:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSJESg3>; Sat, 5 Oct 2002 14:36:29 -0400
Received: from gate.in-addr.de ([212.8.193.158]:18438 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S262445AbSJESg1>;
	Sat, 5 Oct 2002 14:36:27 -0400
Date: Sat, 5 Oct 2002 20:41:53 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021005184153.GJ17492@marowsky-bree.de>
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <20021004140802.E24148@work.bitmover.com> <20021005175437.GK585@phunnypharm.org> <20021005112552.A9032@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021005112552.A9032@work.bitmover.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-05T11:25:52,
   Larry McVoy <lm@bitmover.com> said:

> > I've also been wanting to use bitkeeper to create a Subversion mirror of
> > the kernel repository, but I suspect that my usage falls seriously into
> > this category, as my reasons for doing so are three-fold; allow access
> > to the bkbits repo to folks who don't want to use bk, but with all the
> > joys of an SCM (history, changesets, etc.);

Larry, could you please explain whether _this_ part is fine doing (even if not
by a subversion developer as per your license). Then someone (who wasn't
involved in building the gateway) can run it and not break your license.

I'd suggest that you need to have an interoperability clause for Open Source
software. Otherwise using BK for kernel development suddenly seems like a very
bad idea, because the community has suddenly been locked out of developing a
free SCM (ie, working on CVS, Subversion etc); he couldn't be an effective
kernel developer today (ie, using BK) and also continue working on the other
open source project...

You know I am rather fond of BK and your goals in general, but that would just
suck.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

