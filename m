Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263658AbRFFRKu>; Wed, 6 Jun 2001 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbRFFRKk>; Wed, 6 Jun 2001 13:10:40 -0400
Received: from i1724.vwr.wanadoo.nl ([194.134.214.195]:24448 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S263658AbRFFRKV>; Wed, 6 Jun 2001 13:10:21 -0400
Date: Wed, 6 Jun 2001 19:10:29 +0200
From: Remi Turk <remi@a2zis.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606191029.B893@localhost.localdomain>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010606112207.H15199@dev.sportingbet.com> <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jun 06, 2001 at 06:48:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 06:48:32AM -0400, Alexander Viro wrote:
> On Wed, 6 Jun 2001, Sean Hunter wrote:
> 
> > This is completely bogus. I am not saying that I can't afford the swap.
> > What I am saying is that it is completely broken to require this amount
> > of swap given the boundaries of efficient use. 
> 
> Funny. I can count many ways in which 4.3BSD, SunOS{3,4} and post-4.4 BSD
> systems I've used were broken, but I've never thought that swap==2*RAM rule
> was one of them.
> 
> Not that being more kind on swap would be a bad thing, but that rule for
> amount of swap is pretty common. ISTR similar for (very old) SCO, so it's
> not just BSD world. How are modern Missed'em'V variants in that respect, BTW?

Although I don't have any swap-trouble myself, what I think
most people are having problems with is not that Linux
doesn't have the "you-dont-need-2xRAM-size-swap-if-you-swap-at-all
feature", but that it lost it in 2.4.

-- 
Linux 2.4.5-ac9 #5 Wed Jun 6 18:30:24 CEST 2001
