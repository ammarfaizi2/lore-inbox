Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbREUKHX>; Mon, 21 May 2001 06:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbREUKHN>; Mon, 21 May 2001 06:07:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:43121 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262443AbREUKHG>; Mon, 21 May 2001 06:07:06 -0400
Date: Mon, 21 May 2001 11:56:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521115631.I30738@athlon.random>
In-Reply-To: <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.55709.565823.676709@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 02:02:21AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 02:02:21AM -0700, David S. Miller wrote:
> Please give me a test case that triggers the bug on sparc64

I just given you a test case that triggers on sparc64 in earlier email.
Chris just given a real world example of applications where that kind of
design is useful and there are certainly other kind of apps where that
kind of hardware design can be useful too.

A name of an high end pci32 card that AFIK can trigger those bugs is the
Quadrics which is a very nice piece of hardware btw.

Andrea
