Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbRAEP4z>; Fri, 5 Jan 2001 10:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132113AbRAEP4f>; Fri, 5 Jan 2001 10:56:35 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:61455 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129744AbRAEP4Y>; Fri, 5 Jan 2001 10:56:24 -0500
Date: Fri, 5 Jan 2001 15:56:23 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Chris Mason <mason@suse.com>
cc: <reiserfs-list@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs patch for 2.4.0-final
In-Reply-To: <502300000.978702454@tiny>
Message-ID: <Pine.LNX.4.30.0101051555240.28552-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Chris Mason wrote:

> > Could someone create one single patch for the 2.4.0 ?
> >
> I put all the code into CVS, and Yura is making the official patch now.

Since 2.4.0 final should fix a few i/o performance issues (particuarly
under heavy write loads), a quick few ext2 vs. reiserfs benchmarks would
make very interesting reading ;-)

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
