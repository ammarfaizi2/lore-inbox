Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSDUIbM>; Sun, 21 Apr 2002 04:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSDUIbL>; Sun, 21 Apr 2002 04:31:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65037 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311475AbSDUIbK>; Sun, 21 Apr 2002 04:31:10 -0400
Date: Sun, 21 Apr 2002 09:31:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421093103.A19904@flint.arm.linux.org.uk>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421043811.BHIC5495.out020.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 12:40:11AM -0400, Skip Ford wrote:
> That's only 1 aspect.  The frustrating part is bug reports mailed to the
> list getting a response of "oh, that's fixed in the latest bk tree."
> 
> That's happened a dozen times in the last week...no wonder non-bk users
> feel out of the loop.  I've been staring at the code for a lot of years
> and it's finally just starting to make sense to me, now by the time I see
> it the core hackers have moved on to something else.
> 
> Daily snapshots would be great.

We have hourly snapshots, thanks to the work David Woodhouse and
Rik van Riel did at a moments notice.  Does this satisfy your
concerns above?

I have a suspicion that the problem of conflicting obvious fixes
won't go away.

There's another interesting twist here... - I didn't see any of them on
linux-kernel.

<joke>
I'm a BK user!  GNU patches are being submitted behind my back without
discussion on linux-kernel.  I'm going to remove the SubmittingPatches
document!  It's harming discussion of patches on linux-kernel.
</joke>

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

