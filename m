Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbQKDUnH>; Sat, 4 Nov 2000 15:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQKDUm5>; Sat, 4 Nov 2000 15:42:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7208 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129093AbQKDUmm>; Sat, 4 Nov 2000 15:42:42 -0500
Subject: Re: [PATCH] Re: Negative scalability by removal of  lock_kernel()?(Was:Strange
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Sat, 4 Nov 2000 20:42:49 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011041158450.22526-100000@twinlark.arctic.org> from "dean gaudet" at Nov 04, 2000 12:03:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sA9L-0004nt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Instead, if apache had just done the thing it wanted to do in the first
> > place, the wake-one accept() semantics would have happened a hell of a
> > lot earlier.
> 
> counter-example:  freebsd had wake-one semantics a few years before linux.

And Im sure apache authors can use the utsname() syscall 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
