Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130221AbQKCCDM>; Thu, 2 Nov 2000 21:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130334AbQKCCCw>; Thu, 2 Nov 2000 21:02:52 -0500
Received: from 209-164-222-32.iglobal.net ([209.164.222.32]:47747 "EHLO
	liu.fafner.com") by vger.kernel.org with ESMTP id <S130259AbQKCCCr>;
	Thu, 2 Nov 2000 21:02:47 -0500
From: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Message-Id: <200011030144.TAA08665@liu.fafner.com>
Subject: Re: scsi init problem in 2.4.0-test10? [PATCH]
To: tao@acc.umu.se (David Weinehall)
Date: Thu, 2 Nov 2000 19:44:39 -0600 (CST)
Cc: eamb@liu.fafner.com (Elizabeth Morris-Baker),
        torben@kernel.dk (Torben Mathiasen), linux-kernel@vger.kernel.org
In-Reply-To: <20001103020216.A29681@khan.acc.umu.se> from "David Weinehall" at Nov 03, 2000 02:02:16 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 

	Thank you for the information.
	I will give it some thought and see if I can come up
	with something that will fit both bills...

	The problem is that the disks that I have are
	very wide-spread, I would imagine. Compaq is shipping
	them in their newer machines, so some compromise has
	to be arrived at.
	
	I will look into the matter further.
	Thanks again.

	cheers, 

	eamb

> On Thu, Nov 02, 2000 at 06:24:47PM -0600, Elizabeth Morris-Baker wrote:
> > > 
> > 
> > 	Yes, I know that is in the spec, but truly,
> > 	some scsi devices do act this way....
> > 	Maybe they need to read the spec :>
> > 
> > 	I have included the START_STOP for Matthew, but
> > 	I never see it execute with the ATLAS disks...
> > 	A diff follows for those that want to try it..
> > 
> > 	cheers, 
> > 
> > 	Elizabeth
> 
> Well, if I'm not all mistaken, this is the code that got removed earlier
> on from the kernel because it caused some SCSI-adapters to hang on
> scsi-scan?! If so, what's better: to follow the specs and penalise the
> bad guys, or ignore the specs and penalise the good guys...
> 
> 
> /David Weinehall
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
> //  Project MCA Linux hacker        //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
