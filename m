Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbREVPTE>; Tue, 22 May 2001 11:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbREVPSy>; Tue, 22 May 2001 11:18:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:63024 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261845AbREVPSg>; Tue, 22 May 2001 11:18:36 -0400
Date: Tue, 22 May 2001 17:18:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net,
        "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522171815.F15155@athlon.random>
In-Reply-To: <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010522184409.A791@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, May 22, 2001 at 06:44:09PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 06:44:09PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 22, 2001 at 04:29:16PM +0200, Andrea Arcangeli wrote:
> > Ivan could you test the above fix on the platforms that needs the
> > align_entry hack?
> 
> That was one of the first things I noticed, and I've tried exactly
> that (2 instead of ~1UL).

just in case (I guess it wouldn't matter much but), but are you sure you
tried it with also the locking fixes applied too?

Andrea
