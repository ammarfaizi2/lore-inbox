Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRJaVyG>; Wed, 31 Oct 2001 16:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJaVx4>; Wed, 31 Oct 2001 16:53:56 -0500
Received: from [63.231.122.81] ([63.231.122.81]:11635 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S273364AbRJaVxl>;
	Wed, 31 Oct 2001 16:53:41 -0500
Date: Wed, 31 Oct 2001 14:53:31 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-ID: <20011031145331.S16554@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random> <E15z2WJ-0000wc-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E15z2WJ-0000wc-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Oct 31, 2001 at 10:03:31PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  22:03 +0100, Daniel Phillips wrote:
> Ben reports that his test with 2 Gig memory runs fine, as it does for me, but 
> that it locks up tight with 3.5 Gig, requiring power cycle.  Since I only 
> have 2 Gig here I can't reproduce that (yet).

Sadly, I bought some memory yesterday, and it was only U$30 for 256MB
DIMMs, so $120/GB if you have enough slots.  Not that I'm suggesting
you go out and but more memory Daniel, as you probably have your slots
filled with 2GB, and larger sticks are still bit more expesive.

The only thing that bugs me about the low memory price is that Windows
XP recommends at least 128MB for a workable system.  A year or two ago
that would have been considered a bloated pig, but now they are giving
away 128MB DIMMs with a purchase of XP.  Sad, really.  Maybe M$ is
subsidizing the chipmakers to make RAM cheap so XP can run on peoples'
computers ;-)?  What else would you do with U$50 billion in cash (or
whatever) that M$ has?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

