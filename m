Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbREVQHE>; Tue, 22 May 2001 12:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbREVQGy>; Tue, 22 May 2001 12:06:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1598 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262013AbREVQGp>; Tue, 22 May 2001 12:06:45 -0400
Date: Tue, 22 May 2001 18:06:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net,
        "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522180611.I15155@athlon.random>
In-Reply-To: <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522171815.F15155@athlon.random> <20010522195518.A653@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010522195518.A653@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, May 22, 2001 at 07:55:18PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 07:55:18PM +0400, Ivan Kokshaysky wrote:
> Yes. Though those races more likely would cause silent data
> corruption, but not immediate crash.

Ok. I wasn't sure if it was crashing or not for you.

Andrea
