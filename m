Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbREUBA6>; Sun, 20 May 2001 21:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbREUBAs>; Sun, 20 May 2001 21:00:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54173 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262290AbREUBAd>;
	Sun, 20 May 2001 21:00:33 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.26793.768442.418184@pizda.ninka.net>
Date: Sun, 20 May 2001 18:00:25 -0700 (PDT)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
	<20010519155502.A16482@athlon.random>
	<20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > Well this is news to me.  No drivers understand this.
 > How long has this been the case?  What platforms?

The DMA interfaces may never fail and I've discussed this over and
over with port maintainers a _long_ time ago.

Don't worry Andrew.

Later,
David S. Miller
davem@redhat.com
