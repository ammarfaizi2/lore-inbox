Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbTCLT6f>; Wed, 12 Mar 2003 14:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbTCLT6f>; Wed, 12 Mar 2003 14:58:35 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:56333 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261954AbTCLT6e>; Wed, 12 Mar 2003 14:58:34 -0500
Date: Wed, 12 Mar 2003 15:08:49 -0500
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312200849.GL563@phunnypharm.org>
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312195120.GB7275@work.bitmover.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So we actually captured 100% of the checkin information, both in data
> files and in the pseudo ChangeSet file, not one byte of that is lost.
> All we did is collapse all the branches into the longest possible straight
> line, which is actually for many purposes nicer than the rats nets that
> you get with BK.

Now that wasn't apparent from your original post. You made it sound more
like meta-data was missing (we all know that via the merges, as long as
you picked a line, none of the diffs were missing).

That's good to know, and makes my whole rant kind of pointless now.

I still don't like your move to change the SCCS format. Regardless of
your intentions, it makes my gut hurt. That doesn't mean I don't like
you or what you do. I never said I didn't in this discussion, although
some people decided to get rude on my behalf, when they shouldn't which
triggered others to target people in the discussion with rudeness, which
shouldn't have happened.

I can dislike the change, just the same as you can license your product
and develop it any way you want. The day someone takes that right away
from either of us is when we have a real problem.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
