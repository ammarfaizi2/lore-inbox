Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbREUJCr>; Mon, 21 May 2001 05:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbREUJCh>; Mon, 21 May 2001 05:02:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37793 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262406AbREUJCZ>;
	Mon, 21 May 2001 05:02:25 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.55709.565823.676709@pizda.ninka.net>
Date: Mon, 21 May 2001 02:02:21 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521105944.H30738@athlon.random>
In-Reply-To: <20010519155502.A16482@athlon.random>
	<20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > Tell me a best way to get rid of those bugs all together if you can.

Please give me a test case that triggers the bug on sparc64
and I will promptly work on a fix, ok?

I mean a test case you _actually_ trigger, not some fantasy case.

In theory it can happen, but nobody is showing me that it actually
does ever happen.

Later,
David S. Miller
davem@redhat.com
