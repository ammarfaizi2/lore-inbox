Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSGXXbz>; Wed, 24 Jul 2002 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318049AbSGXXbz>; Wed, 24 Jul 2002 19:31:55 -0400
Received: from bitmover.com ([192.132.92.2]:5844 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318020AbSGXXby>;
	Wed, 24 Jul 2002 19:31:54 -0400
Date: Wed, 24 Jul 2002 16:35:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Kenneth Johansson <ken@kenjo.org>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: bk://linux.bkbits.net/linux-2.[45] pull error
Message-ID: <20020724163502.B21335@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kenneth Johansson <ken@kenjo.org>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	linux-kernel@vger.kernel.org
References: <m37kjlmt2k.fsf@lugabout.jhcloos.org> <20020724061339.E2703@work.bitmover.com> <20020724140939.GE718@tahoe.alcove-fr> <1027538810.11340.23.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1027538810.11340.23.camel@tiger>; from ken@kenjo.org on Wed, Jul 24, 2002 at 09:26:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 09:26:50PM +0200, Kenneth Johansson wrote:
> On Wed, 2002-07-24 at 16:09, Stelian Pop wrote:
> > On Wed, Jul 24, 2002 at 06:13:39AM -0700, Larry McVoy wrote:
> > 
> > > We ran out of disk space, it's fixed.  Thanks for the message.
> > 
> > While we are at it, could you please push the Linus tree 
> > (http://linus.bkbits.net/linux-2.5) to the Linux tree 
> > (http://linux.bkbits.net/linux-2.5) manualy again.
> > 
> > /me really wonders if this couldn't be automated somehow...
> 
> Why two trees ?

Because nobody pulls from Linus' tree so it is never locked.  He can push
to that and then it's up to yours truly to push it up and wait for locks.
It's actually a non-problem these days, it was a problem right after the
linux.bkbits.net trees went up because people were cloning them over modems
and they were locked forever.  Linus was already less than thrilled with
our locking approach and this was just too lame for him to deal with so
I set up the extra tree.  It could probably go away but since it works
and the point of BK wrt Linux was to offload Linus, I'm not going to go
yank his chain.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
