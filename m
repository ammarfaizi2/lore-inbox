Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVLGVxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVLGVxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVLGVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:53:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:34494 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030376AbVLGVxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:53:48 -0500
To: "David S. Miller" <davem@davemloft.net>
cc: davej@redhat.com, geert@linux-m68k.org, arjan@infradead.org,
       rdunlap@xenotime.net, riel@redhat.com, andrea@suse.de,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, ogasawara@osdl.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Linux in a binary world... a doomsday scenario 
In-reply-to: Your message of Wed, 07 Dec 2005 13:38:20 PST.
             <20051207.133820.39286690.davem@davemloft.net> 
Date: Wed, 07 Dec 2005 13:53:39 -0800
Message-Id: <E1Ek7EJ-0006nu-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2005 13:38:20 PST, "David S. Miller" wrote:
> From: Gerrit Huizenga <gh@us.ibm.com>
> Date: Wed, 07 Dec 2005 13:30:18 -0800
> 
> > OSDL.org has no desire to advocate binary drivers in any way and I
> > don't expect that they will do anything to educate or influence their
> > members or the global vendor/IHV/developer communities to use binary
> > drivers.  Further, I expect they will do exactly the opposite, in
> > particular, educate members, developers, IHV's on how to deploy
> > open source drivers and the benefits of doing so.
> 
> You might want to read the following before stating such
> things:
> 
> 	http://www.kroah.com/log/2005/11/03/#osdl_gkai
> 
> Thanks.

I have read that and in fact I was at that meeting.  That was a case
where we had spent some time trying to convince member companies that
a stable kernel API was not going to happen.  They did not believe it.
Greg and others came in and expressed directly to those people their
viewpoints.  That has helped and the companies in question are still
thinking about their future strategy.  Greg had an impact where OSDL
members (myself included) were simply viewed as expressing a radical
opinion which reality would change.

This whole concept of drivers being broken has been painful for everyone
and people are still trying to apply traditional solutions.  The kernel
communities solution solves a piece of the problem (not the distro portion
of the problem) but the continuing education on a pardaigm shift seems
to be unending.  I've been working on this for over a year and I still
run into people every day that just don't see the value of the paradigm
change and don't even realize that there *is* a paradigm change.

Wishing the problem away hasn't helped.  People need education and all
kinds of levels and unfortunately LKML doesn't reach most of the people
that actually need the education.  :(

gerrit
