Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313091AbSDDCpc>; Wed, 3 Apr 2002 21:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSDDCpN>; Wed, 3 Apr 2002 21:45:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:772 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313091AbSDDCpH>; Wed, 3 Apr 2002 21:45:07 -0500
Date: Wed, 3 Apr 2002 21:42:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 vs. ext3 recovery after crash
In-Reply-To: <20020403145248.EBBD7B7802@dungeon.inka.de>
Message-ID: <Pine.LNX.3.96.1020403213214.185B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Andreas Jellinghaus wrote:

> >I have a laptop (Dell Inspiron C600) which, like most Dell laptops,
> >crashes every time I log out of X.
> 
> There is an Inspirion C600?
> i have a litutude c600, and it works fine.

Man, good to see I'm not the only one who can't type ;-)

Yeah, the other laptop is an Inspiron I guess, I was googling for Dell and
Linux problems and had a brain fart. That said, yes, I have a "Latitude
C600" here, and when I exit X via logout it almost always hangs, the
screen turns pink, and I need to power cycle.

Given that yours doesn't do that, did you use:
- a custom XF86 config
- XFree from someone other than Redhat
- some custom config of X
- anything else you did?

Obviously I would rather not have the system hang all the time, better
even than having it boot fast ;-)

I've been running *very* recent kernels, mainly because the RH didn't work
any better. If you have a better install I'd like to hear it, although the
issues which pushed me to NSLG and 19-pre2 or news kernels are hard to
ignore.

Then again, several people have told me that they had multiple Dell
laptops and only some of them did this. Can you say "quality control" or
"running production changes?"

Thanks much for anything you can suggest, but in the meantime I will be
saving some dmesg output from ext2 and ext3 boots.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

