Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131961AbQKBA2I>; Wed, 1 Nov 2000 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbQKBA16>; Wed, 1 Nov 2000 19:27:58 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:11218 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S131961AbQKBA1l>; Wed, 1 Nov 2000 19:27:41 -0500
Date: Thu, 2 Nov 2000 00:59:27 +0100
From: David Weinehall <tao@acc.umu.se>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: wnoise@ugcs.caltech.edu, mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: working userspace nfs v3 for linux?
Message-ID: <20001102005927.A26355@khan.acc.umu.se>
In-Reply-To: <linux.kernel.3A008510.FAE271A1@holly-springs.nc.us> <slrn9015t8.u5t.wnoise@barter.ugcs.caltech.edu> <3A00A84E.F3A1C585@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A00A84E.F3A1C585@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Wed, Nov 01, 2000 at 06:33:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 06:33:34PM -0500, Michael Rothwell wrote:
> Aaron Denney wrote:
> > I am not aware of any userspace NFSv3 server.  Your best bet would
> > probably to take the v2 server and mutate it.  Why do you want this beast?
> 
> So I can use Linux rather than Solaris 7 and the Solstice Disk Suite,
> which performs like crap thanks to UFS, and the Linux NFS v2
> implementation.

Yes, but why do you need a userspace NFSv3 server? v2.2.18 will contain
knfsdv3, shouldn't this be good enough?


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
