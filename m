Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132810AbRAFTcO>; Sat, 6 Jan 2001 14:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRAFTcE>; Sat, 6 Jan 2001 14:32:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50955 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132810AbRAFTb5>; Sat, 6 Jan 2001 14:31:57 -0500
Subject: Re: Linux-2.4.x patch submission policy
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 6 Jan 2001 19:33:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <937neu$p95$1@penguin.transmeta.com> from "Linus Torvalds" at Jan 06, 2001 10:17:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ez5g-0001QJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> rather spend the time _really_ beating on the patches that _would_ be a
> big issue.  Things like security (_especially_ remote attacks), outright
> crashes, or just totally unusable systems because it can't see the
> harddisk. 

In which case the priority should be fixing all the broken LFS support.

> Yes, I know this is boring, and all I'm asking is for people to not make
> it any harder for me than they have to.  Think twice before sending me a
> patch, and when you _do_ send me a patch, try to think like a release
> manager and explain to me why the patch really makes sense to apply now. 

Think of -ac as a way to get patches you need that everyone else might not
need yet, and a way to filter stuff. Im happy to take sane stuff Linus doesn't
(within reason) and propogate it on as (or more to the point if) it proves sane

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
