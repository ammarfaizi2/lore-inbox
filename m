Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLHBQT>; Thu, 7 Dec 2000 20:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbQLHBQJ>; Thu, 7 Dec 2000 20:16:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129450AbQLHBP5>; Thu, 7 Dec 2000 20:15:57 -0500
Subject: Re: Linux 2.2.18pre25
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 8 Dec 2000 00:47:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001208014146.A24858@inspiron.random> from "Andrea Arcangeli" at Dec 08, 2000 01:41:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144Bhf-0003GN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (note: the above is outdated so it's not anymore suggested for inclusion of
> course)
> 
> I sumbitted most of the not-feature-oriented stuff at pre2 time and I plan to
> re-submit after 2.2.18 is released.

Excellent. I've been trying to avoid VM fixes for 2.2.18 to stop stuff getting
muddled together and hard to debug. Running with page aging convinces me that
2.2.19 we need to sort some of the vm issues out badly, and make it faster than
2.4test 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
