Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318457AbSGSLeE>; Fri, 19 Jul 2002 07:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSGSLeE>; Fri, 19 Jul 2002 07:34:04 -0400
Received: from t5o913p66.telia.com ([212.181.179.66]:24961 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S318457AbSGSLeD>;
	Fri, 19 Jul 2002 07:34:03 -0400
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@suse.de>, Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
References: <3D361091.13618.16DC46FB@localhost>
	<Pine.LNX.3.96.1020718123016.8220B-100000@gatekeeper.tmr.com>
	<20020718222229.B21997@suse.de> <m2ele0ldlx.fsf@best.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Jul 2002 11:40:38 +0200
In-Reply-To: <m2ele0ldlx.fsf@best.localdomain>
Message-ID: <m23cug6oo9.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Dave Jones <davej@suse.de> writes:
> 
> > On Thu, Jul 18, 2002 at 12:46:43PM -0400, Bill Davidsen wrote:
> > 
> >  > > o UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
> >  > 	Hopefully this is close as well
> > 
> > This has been around for an age, but I haven't seen anything for 2.5
> > yet. Then again, I dropped off the packet-writing mailing list a long
> > time ago, so I'm not sure how up to date those folks are.
> 
> Patches for 2.5 can be found here:
> 
>         http://w1.894.telia.com/~u89404340/patches/packet/2.5/
> 
> The most recent patch is for 2.5.25. As far as I know, there are only
> two remaining problems with the 2.5 patch:

Btw, there is one more potential problem. A new block major number is
allocated for the pktcdvd device. Is this still forbidden? Are there
better ways to do this now?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
