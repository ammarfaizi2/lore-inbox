Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbSLPQcp>; Mon, 16 Dec 2002 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbSLPQcp>; Mon, 16 Dec 2002 11:32:45 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:4359 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266796AbSLPQco>; Mon, 16 Dec 2002 11:32:44 -0500
Date: Mon, 16 Dec 2002 11:40:32 -0500
From: Ben Collins <bcollins@debian.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
Message-ID: <20021216164032.GU504@hopper.phunnypharm.org>
References: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com> <20021216102639.A27589@infradead.org> <20021216151639.GQ504@hopper.phunnypharm.org> <20021216163631.A5342@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216163631.A5342@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Trying to track two seperate source tree's isn't as easy as you might think.
> 
> In fact it's not difficult at all with a proper SCM, a bit of care and the
> right attitude.  I merge the changes from XFS (and about half a donzend
> XFS-related repositories inside SGI that all need proper merging / keeping
> in sync) to Linus all the time.  And by keeping the changesets (or atomic
> commits in SVN terminlogoy) as one patch each, hand-editing as needed when
> merge conflicts arrive that works very well, even if I had been away and
> the changes for four weeks need merging or as now we're five patchlevels
> away from Linus tree (at 2.5.47).  I've not lost a single upstream change
> with that merge policy yet.
> 
> And no, that's no BK advertisment, SGI uses a RCS-based SCM internally and
> I use unfied diffs to get it into a staging repository for Linus to pull.

When someone pays me to work fulltime on Linux1394, I'll give it that
much time. Until then I have to make due with what time I have. If I
miss things because people would rather send patches to Linus than me,
it isn't my fault, but I'll do my best to fix it up.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
