Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVGKAWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVGKAWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGKATl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:19:41 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:15629 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262073AbVGKASi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:18:38 -0400
Date: Sun, 10 Jul 2005 20:18:14 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Ed Cogburn <edcogburn@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050711001814.GH3550@mail>
Mail-Followup-To: Ed Cogburn <edcogburn@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl> <200507100848.05090.tomlins@cam.org> <200507102006.27152.adobriyan@gmail.com> <20050710202129.GA3550@mail> <dascln$lq3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dascln$lq3$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/05 08:01:26PM -0400, Ed Cogburn wrote:
> Jim Crilly wrote:
> 
> > But in most of the changesets on the bkbits site you can go back over 2
> > years and not see anything from namesys people. Nearly all of the fixes 
> > commited in the past 2-3 years are from SuSe.
> 
> 
> So, for the sake of argument, if IBM were to drop official support for JFS,
> we'd yank JFS out of the kernel even if there was someone else willing to
> support it?  Why does it now *matter* who supports it, as long as its being
> maintained?  And will we now block IBM's hypothetical JFS2 from the kernel
> if IBM, from the programmers up to the CEO, doesn't swear on their momma's
> grave that they'll continue to support JFS1, even if JFS1 is being
> supported by others?  Jeez, this is why it doesn't take a kernel dev to see
> the problems here, common sense seems to be an increasingly rare ingredient
> in these arguments against R4.  If I didn't know better, I'd think you were
> making this stuff up as you went along....

Someone other than Namesys maintaing the filesystem isn't the problem. XFS
for instance has had a lot of work done by non-SGI employees after it's
merge, but SGI doesn't release a new filesystem every 3 years with the
desire to remove and replace the old one. The main problems with reiser4
have been beat to death, if you don't get it by now chances are that you
won't. Having Hans and team run off to work on reiser5 6 months after
inclusion is an issue, since it seems to have happened before, but it's a
minor one as long as reiser4 is merged in a state where it can be manged by
other people without too much trouble.

Jim.

> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
