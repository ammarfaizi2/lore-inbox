Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135258AbRDRS6L>; Wed, 18 Apr 2001 14:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbRDRS5v>; Wed, 18 Apr 2001 14:57:51 -0400
Received: from mail.gator.net ([209.251.152.21]:61701 "EHLO mail.gator.net")
	by vger.kernel.org with ESMTP id <S135258AbRDRS5m>;
	Wed, 18 Apr 2001 14:57:42 -0400
Date: Wed, 18 Apr 2001 14:55:58 -0400 (EDT)
From: Blue Lang <blue@gator.net>
To: <linux-kernel@vger.kernel.org>
Subject: SpecSFS/ext2
Message-ID: <Pine.LNX.4.30.0104181452360.8073-100000@mail.gator.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

I'm in the middle of some interesting conversation at work WRT ext2's
fitness for 'production' use.

The crux of my question, if anyone out there is familiar with the SpecSFS
benchmark, is whether or not ext2 can be benchmarked under an nfs mount
exported with the 'sync' option.

If not, do the O_SYNC patches qualify ext2 for the level of syncronous
writes that SpecSFS requires?

Opinions?

Thanks!

-- 
   Blue Lang                                    http://www.gator.net/~blue
   2315 McMullan Circle, Raleigh, North Carolina, USA         919 835 1540

