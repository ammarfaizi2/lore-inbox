Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130892AbRAQJQV>; Wed, 17 Jan 2001 04:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131176AbRAQJQL>; Wed, 17 Jan 2001 04:16:11 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:61395 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130892AbRAQJP7>; Wed, 17 Jan 2001 04:15:59 -0500
Date: Wed, 17 Jan 2001 10:15:56 +0100
From: David Weinehall <tao@acc.umu.se>
To: Stefan Ring <e9725446@student.tuwien.ac.at>
Cc: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.0.37 crashes immediately
Message-ID: <20010117101556.B2399@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.21.0101161605570.17397-100000@sol.compendium-tech.com> <Pine.HPX.4.10.10101170957350.29885-100000@stud3.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.HPX.4.10.10101170957350.29885-100000@stud3.tuwien.ac.at>; from e9725446@student.tuwien.ac.at on Wed, Jan 17, 2001 at 10:00:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 10:00:31AM +0100, Stefan Ring wrote:
> On Tue, 16 Jan 2001, Dr. Kelsey Hudson wrote:
> 
> > Is there a reason you are using a relatively new machine like that with
> > such an outdated and arcane kernel (and distribution, for that
> > matter)? I'd suggest you upgrade to a more recent kernel and/or
> > distribution...it'll be a lot more stable (and not to mention secure!)
> 
> Every version above 2.0.36 behaves the same (from the 2.0.x series).
> Gee, I should have said a few words about my intent. Of course, I'm
> not actually using these old versions of everything. I just wanted to
> run a 2.0.x kernel to do some hardware testing, and since 2.0.x can't
> access the new ext2fs with the spare superblock option, I thought, I
> might be up and running fastest by installing a RH distribution still
> using the 2.0.x kernel. It just happened that RH4.2 was the only one I
> had handy at that moment.

Actually, v2.0.39 _does_ cope with sparse superblocks.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
