Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbRAGV1X>; Sun, 7 Jan 2001 16:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbRAGV1N>; Sun, 7 Jan 2001 16:27:13 -0500
Received: from [194.73.73.138] ([194.73.73.138]:21985 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S132204AbRAGV05>;
	Sun, 7 Jan 2001 16:26:57 -0500
Date: Sun, 7 Jan 2001 21:21:45 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <dnitnrcbji.fsf@magla.iskon.hr>
Message-ID: <Pine.LNX.4.31.0101072120310.5027-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Zlatko Calusic wrote:

> Anyway, I would than suggest to introduce another /proc entry and call
> it appropriately: max_async_pages. Because that is what we care about,
> anyway. I'll send another patch.

Anton Blanchard already did a patch for this. Sent to the list
on Thu, 7 Dec 2000 16:15:54 +1100 subject:
[PATCH]: sysctl to tune async and sync bdflush triggers

I don't recall seeing any responses to that patch, but it seems
to do exactly what you describe.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
