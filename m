Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbTCLUJm>; Wed, 12 Mar 2003 15:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbTCLUJl>; Wed, 12 Mar 2003 15:09:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15315 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261921AbTCLUJj>;
	Wed, 12 Mar 2003 15:09:39 -0500
Message-ID: <3E6F9692.4010201@pobox.com>
Date: Wed, 12 Mar 2003 15:20:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Nicolas Pitre <nico@cam.org>, Larry McVoy <lm@work.bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
References: <20030312183413.GH563@phunnypharm.org> <Pine.LNX.4.44.0303121426450.14172-100000@xanadu.home> <20030312195311.GK563@phunnypharm.org>
In-Reply-To: <20030312195311.GK563@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> What part of the structure of the BK repo don't you understand? Didn'y
> you pay attention to what Larry said? The tree looks like branches that
> always return to the trunk. To put this into CVS, he had to choose a
> line of those branches that contained the _most_ changesets (which
> doesn't always equate to the most important, or largest deltas). There
> are some changesets on the side that are not included here. Are all of
> those changesets empty merges? No.


What are you attempting to insinuate?

I think BK had has positive benefits to all Linux kernel hackers, 
whether or not they use BitKeeper.  The current patch flow is pretty 
amazing, and we seemed to have avoided the Linus burn-out that 
threatened to come to pass pre-BK.

It's getting to the point where it seems like every time BitMover does 
something to appease the non-BK crowd, people (a) read evil intentions 
into the action, and/or (b) just keep asking for more.

Can someone please tell what is the overall point?  what is the endgame 
here?  what is a concrete technical solution that will satisfy you 
(Ben), Pavel, and everybody else?

	Jeff



