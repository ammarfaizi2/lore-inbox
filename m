Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLIGD6>; Sat, 9 Dec 2000 01:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129801AbQLIGDt>; Sat, 9 Dec 2000 01:03:49 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:50657 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S129784AbQLIGDj>; Sat, 9 Dec 2000 01:03:39 -0500
Date: Sat, 9 Dec 2000 05:32:54 +0000 (GMT)
From: davej@suse.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
Message-ID: <Pine.LNX.4.21.0012090527490.9650-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse (dwmw2@infradead.org) wrote...

> Can you reproduce it with bcrl's patch below: 

Did nothing for me. gcc still got a sig11 after a while.
Took three runs of 'make bzImage' before it completed.

I wondered if I'd been unlucky enough to have been sent a
replacement K6-2 which was also screwed, but as I mentioned
earlier, this box runs fine under 2.2

btw, I was unsubscribed from all lists at vger yesterday,
for reasons currently unknown to me. Did this happen to anyone
else, or did my mail setup break something?

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
