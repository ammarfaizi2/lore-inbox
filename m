Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbTCLT7V>; Wed, 12 Mar 2003 14:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261980AbTCLT7U>; Wed, 12 Mar 2003 14:59:20 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:57357 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261979AbTCLT7S>; Wed, 12 Mar 2003 14:59:18 -0500
Date: Wed, 12 Mar 2003 15:09:48 -0500
From: Ben Collins <bcollins@debian.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Larry McVoy <lm@work.bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312200948.GM563@phunnypharm.org>
References: <20030312183413.GH563@phunnypharm.org> <Pine.LNX.4.44.0303121426450.14172-100000@xanadu.home> <20030312195311.GK563@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312195311.GK563@phunnypharm.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oh of course you won't trust Larry and maybe he's trying to screw you with 
> > that 10% by carefully crafting essential details in there so you'll end up 
> > being forced into buying a BK license otherwise you won't be able to make 
> > any sense of what happened in the source tree, or even make it compile!  
> > Isn't it pure paranoia?
> > 
> 
> What part of the structure of the BK repo don't you understand? Didn'y
> you pay attention to what Larry said? The tree looks like branches that
> always return to the trunk. To put this into CVS, he had to choose a
> line of those branches that contained the _most_ changesets (which
> doesn't always equate to the most important, or largest deltas). There
> are some changesets on the side that are not included here. Are all of
> those changesets empty merges? No.

s/changeset/metadata/ to clarify my point, which is of no use now.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
