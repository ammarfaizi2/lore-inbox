Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291020AbSCGDEp>; Wed, 6 Mar 2002 22:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291022AbSCGDEg>; Wed, 6 Mar 2002 22:04:36 -0500
Received: from bitmover.com ([192.132.92.2]:47489 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291020AbSCGDE0>;
	Wed, 6 Mar 2002 22:04:26 -0500
Date: Wed, 6 Mar 2002 19:04:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Lord <lord@regexps.com>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Why not an arch mirror for the kernel?
Message-ID: <20020306190419.E31751@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Lord <lord@regexps.com>, linux-kernel@vger.kernel.org,
	davej@suse.de
In-Reply-To: <200203071425.GAA06679@morrowfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203071425.GAA06679@morrowfield.home>; from lord@regexps.com on Thu, Mar 07, 2002 at 06:25:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 06:25:12AM -0800, Tom Lord wrote:
> 	Dave Jones observes:
> 
> 	Something I've not yet worked out is why none of the
> 	proponents of arch, subversion etc are offering to run a
> 	mirror of Linus' bitkeeper tree for those who don't want to
> 	use bk, but "must have 0-day kernels".

It's amazing to me that all these people who don't like the license,
or are having a bad day, or are 18 year old boys who can't write code
so they are killing time by being self appointed license police,
all of these people could download BK, spend 5 minutes reading the docs,
and write a 5 line shell script which would export each pre-release and
release as a patch from BK.  It's trivial.  There's no excuse for anyone
to be whining about the BK license, they can use BK to get the data into
whatever bloody system satisfies their religion and be done with it.

> I am working on some tools that will help to implement automatic,
> incremental, bidirectional gateways between arch, Subversion, and Bk.

Gateways, yes, bidirectional, no.  Arch doesn't begin to maintain
the metadata which BK maintains, so it can't begin to solve the
same problems.  If you have a bidirectional gateway, you reduce BK
to the level of arch or subversion, in which case, why use BK at all?
If CVS/Arch/Subversion/whatever works for you, I'd say just use it and
leave BK out of it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
