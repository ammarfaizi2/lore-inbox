Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbTCHWmX>; Sat, 8 Mar 2003 17:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbTCHWmX>; Sat, 8 Mar 2003 17:42:23 -0500
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:7049 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S262295AbTCHWmV>;
	Sat, 8 Mar 2003 17:42:21 -0500
Date: Sat, 8 Mar 2003 14:52:52 -0800
From: Zack Brown <zbrown@tumblerings.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030308225252.GA23972@renegade>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b98v$14m$1@penguin.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Mar 07, 2003 at 11:16:47PM +0000, Linus Torvalds wrote:
> In article <20030307190848.GB21023@atrey.karlin.mff.cuni.cz>,
> Pavel Machek  <pavel@suse.cz> wrote:
> >
> >So, basically, if branch was killed and recreated after each merge
> >from mainline, problem would be solved, right?
> 
> Wrong.
> 
> Now think three trees.  Each merging back and forth between each other. 
> 
> Or, in the case of something like the Linux kernel tree, where you don't
> have two or three trees.  You've got at least 20 actively developed
> concurrent trees with branches at different points. 
> 
> Trust me. CVS simple CANNOT do this. You need the full information.
> 
> Give it up.  BitKeeper is simply superior to CVS/SVN, and will stay that
> way indefinitely since most people don't seem to even understand _why_
> it is superior. 

You make it sound like no one is even interested ;-). But it's not true! A
lot of people currently working on alternative version control systems would
like very much to know what it would take to satisfy the needs of kernel
development. Maybe, being on the inside of the process and well aware of
your own needs, you don't realize how difficult it is to figure these things
out from the outside. I think only very few people (perhaps only one) really
understand this issue, and they aren't communicating with the horde of people
who really want to help, if only they knew how.

My impression is that Pavel is really smart and pretty close to the core of
kernel development. But you say even he doesn't get it? Come on! Throw
us a bone, willya!? ;-)

Be well,
Zack

> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zack Brown
