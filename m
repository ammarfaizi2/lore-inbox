Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRJZCRg>; Thu, 25 Oct 2001 22:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277322AbRJZCR0>; Thu, 25 Oct 2001 22:17:26 -0400
Received: from queen.bee.lk ([203.143.12.182]:56705 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S277317AbRJZCRJ>;
	Thu, 25 Oct 2001 22:17:09 -0400
Date: Fri, 26 Oct 2001 08:17:28 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: bert hubert <ahu@ds9a.nl>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.13..
Message-ID: <20011026081728.A14607@bee.lk>
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com> <20011024114026.A14078@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011024114026.A14078@outpost.ds9a.nl>; from ahu@ds9a.nl on Wed, Oct 24, 2001 at 11:40:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 11:40:26AM +0200, bert hubert wrote:
>
> On Tue, Oct 23, 2001 at 10:52:28PM -0700, Linus Torvalds wrote:
> >
> > final:
> >  - page write-out throttling
> >  - Pete Zaitcev: ymfpci sound driver update (make Civ:CTP happy with it)
> >  - Alan Cox: i2o sync-up
> >  - Andrea Arcangeli: revert broken x86 smp_call_function patch
> >  - me: handle VM write load more gracefully. Merge parts of -aa VM
> 
> Why do we do the exciting VM things in 'final'? We are confusing people with
> pre-patches that are better than actual releases!

IMHO _nothing_ should be done for the final.  A better alternative is to name a
stable pre kernel as a final without changes.  In the current scenario, a final
kernel release is one which is _not_ tested.

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

The most important design issue... is the fact that Linux is supposed to 
be fun...
	-- Linus Torvalds at the First Dutch International Symposium on Linux

