Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHMNKv>; Tue, 13 Aug 2002 09:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHMNKv>; Tue, 13 Aug 2002 09:10:51 -0400
Received: from [64.105.35.243] ([64.105.35.243]:1922 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S315278AbSHMNKu>;
	Tue, 13 Aug 2002 09:10:50 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 13 Aug 2002 06:14:30 -0700
Message-Id: <200208131314.GAA00444@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.30 IDE 115
Cc: axboe@suse.de, dalecki@evision.ag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> = Marcin Dalecki
>> = Jens Axboe
> = Marcin Dalecki

>>> Oh, I realize I didn't express myself properly. I certinaly don't intend
>>> to eliminate elv_add_request() itself any time soon ;-).

>> No, I would appreciate it if you would keep your hands out of the block
>> code.

>OK. I have enough.

	I have confirmed by email with Jens (cc'ed to Martin) that
Jens did not mean that Martin should step down as IDE maintainer
or anything like that.

	Jens was referring to the generic block code that he
maintains (including elv_add_request and drivers/block/block_ioctl.c,
which Martin had submitted patch for in IDE 115 without consulting
with Jens).

	Personally, I hope that Martin stays on as IDE maintainer.
Getting IDE to a maintainable state was a minefield that had to
be crossed.  Could someone else have done with fewer mistakes?
Maybe, but there was plenty of time for someone else to do it,
and nobody stepped up to the plate.  Of course there is a
trade-off point that point is more conservatively set with the
software that controls disk storage, but, in general, I think
it's important to be supportive of those who actually produce.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
