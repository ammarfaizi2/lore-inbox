Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319107AbSIKPPS>; Wed, 11 Sep 2002 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319111AbSIKPPS>; Wed, 11 Sep 2002 11:15:18 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54537 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319107AbSIKPPR>; Wed, 11 Sep 2002 11:15:17 -0400
Date: Wed, 11 Sep 2002 11:12:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andi Kleen <ak@suse.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS?
In-Reply-To: <p73wupuq34l.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.3.96.1020911110502.12605A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Sep 2002, Andi Kleen wrote:

> Thunder from the hill <thunder@lightweight.ods.org> writes:
> 
> > Hi,
> > 
> > On Mon, 9 Sep 2002, khromy wrote:
> > > What's up with XFS in linux-2.5? I've seen some patches sent to the list
> > > but I havn't seen any replies from linus.. What needs to be done to
> > > finally merge it?
> > 
> > It has been stated quite regularly that XFS
> > a) doesn't always work like it should yet
> 
> That's quite bogus. While not being perfect XFS just works fine for lots
> of people in production and performs very well for a lot of tasks.

More to the point, a quick scan of LKML will show that there are fixes for
ext3 and reisser on a regular basis, so one must assume that they don't
always work as they should either. XFS is in a number of distributions,
and is stable for users.
 
> > b) involves some changes which Linus doesn't like in particular, for 
> >    pretty good reasons.
> 
> I think that's FUD too. That last patch had 6 lines or so of changes 
> to generic code, everything else was already merged.

Does that mean he should only dislike it a little because it's small? At
this stage I would hope he will at least tell you why it wasn't accepted,
since XFS is a desirable feature for many people (as evidence vendors
providing it).

I'd like XFS, I think it's a good feature politically, hopefully it will
not just drop just as it's becoming stable for non-critical production
use.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

