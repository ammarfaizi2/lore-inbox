Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTBNRPO>; Fri, 14 Feb 2003 12:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBNRPO>; Fri, 14 Feb 2003 12:15:14 -0500
Received: from bitmover.com ([192.132.92.2]:24747 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261660AbTBNRO0>;
	Fri, 14 Feb 2003 12:14:26 -0500
Date: Fri, 14 Feb 2003 09:24:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Lang <david.lang@digitalinsight.com>,
       "Matthew D. Pitts" <mpitts@suite224.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030214172411.GC6564@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tomas Szepe <szepe@pinerecords.com>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Lang <david.lang@digitalinsight.com>,
	"Matthew D. Pitts" <mpitts@suite224.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302132224470.656-100000@dlang.diginsite.com> <1045233701.7958.14.camel@irongate.swansea.linux.org.uk> <20030214153039.GB3188@work.bitmover.com> <1045241763.1353.19.camel@irongate.swansea.linux.org.uk> <20030214164720.GC200@louise.pinerecords.com> <20030214165041.GA6564@work.bitmover.com> <20030214170915.GE200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214170915.GE200@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sure, you can do it.
> > 
> > 	bk clone bk://typhoon.bkbits.net/typhoon-2.4
> > 	cd typhoon-2.4
> > 	bk export -tpatch -r1.967,1.968 | mail alan@lxorguk.ukuu.org.uk
> 
> Oh, was I asking whether *I* could do this?
> Is my memory failing me so horribly?
> 
> No really, I can't see why you have decided to ignore this feature
> request already in its embryo stage.  It would be very useful IMHO.

Because it costs money for bandwidth.  I agree it would be useful, so
find someone to cough up the $15K/year for the bandwidth and you can
have the diff interface you want.  The code is already written, it has
been for more than a year, it's simply a money issue.

To put this more into perspective, the real problem is that we share the
T1 line you guys use to get at bkbits.net with our voice over IP phone
system and every time one of you use the net, the phones sound like 
something from a bad B movie.  We've tried all sorts of traffic shaping
and it doesn't work, the phones suck when they can't get the wire.
It's bad enough now, it would be intolerable if we were a patch server.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
