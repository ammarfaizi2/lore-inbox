Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSHWl>; Sun, 19 Nov 2000 02:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131716AbQKSHWb>; Sun, 19 Nov 2000 02:22:31 -0500
Received: from blue.cdf.toronto.edu ([128.100.31.7]:13316 "EHLO
	blue.cdf.utoronto.ca") by vger.kernel.org with ESMTP
	id <S129152AbQKSHWS>; Sun, 19 Nov 2000 02:22:18 -0500
Date: Sun, 19 Nov 2000 02:03:42 -0500 (EST)
From: Andrew Park <apark@cdf.toronto.edu>
To: linux-kernel@vger.kernel.org
Subject: neighbour table?
In-Reply-To: <3A17739A.29AFFAC6@linux.com>
Message-ID: <Pine.LNX.4.21.0011190158480.3036-100000@blue.cdf.utoronto.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a message

	neighbour table overflow

What does that mean?  It seems that

	net/ipv4/route.c

is the place where it prints this.  But under what circumstances
does this happen?
Thanks

-A.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
