Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbRAQJBG>; Wed, 17 Jan 2001 04:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAQJAr>; Wed, 17 Jan 2001 04:00:47 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:13320 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S129860AbRAQJAn>; Wed, 17 Jan 2001 04:00:43 -0500
Date: Wed, 17 Jan 2001 10:00:31 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0.37 crashes immediately
In-Reply-To: <Pine.LNX.4.21.0101161605570.17397-100000@sol.compendium-tech.com>
Message-ID: <Pine.HPX.4.10.10101170957350.29885-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Dr. Kelsey Hudson wrote:

> Is there a reason you are using a relatively new machine like that with
> such an outdated and arcane kernel (and distribution, for that
> matter)? I'd suggest you upgrade to a more recent kernel and/or
> distribution...it'll be a lot more stable (and not to mention secure!)

Every version above 2.0.36 behaves the same (from the 2.0.x series). Gee,
I should have said a few words about my intent. Of course, I'm not
actually using these old versions of everything. I just wanted to run a
2.0.x kernel to do some hardware testing, and since 2.0.x can't access the
new ext2fs with the spare superblock option, I thought, I might be up and
running fastest by installing a RH distribution still using the 2.0.x
kernel. It just happened that RH4.2 was the only one I had handy at that
moment.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
