Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131794AbQKVQVI>; Wed, 22 Nov 2000 11:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132030AbQKVQUs>; Wed, 22 Nov 2000 11:20:48 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:5345 "EHLO
        carbon.btinternet.com") by vger.kernel.org with ESMTP
        id <S131794AbQKVQUo>; Wed, 22 Nov 2000 11:20:44 -0500
Date: Wed, 22 Nov 2000 15:50:27 +0000 (GMT)
From: davej@suse.de
To: kumon@flab.fujitsu.co.jp
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <200011221059.TAA03907@asami.proc.flab.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.21.0011221548080.6184-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 kumon@flab.fujitsu.co.jp wrote:

> The current Linux has a lot of difficult to set parameters in
> /proc/sys.
>  Once a system goes beyond some settable limits, the system behavior
> changes so sharp.  Bdf_prm.nrfract in fs/buffer.c is one of the
> difficult parameters.  I hope a tool to monitor or set these value.

http://www.powertweak.org
(See CVS version). Helpful(?) advice, profiles, and easy to use UI.
If we missed anything, we take patches, and can always use extra hands :)

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
