Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132010AbRAEPzz>; Fri, 5 Jan 2001 10:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbRAEPzp>; Fri, 5 Jan 2001 10:55:45 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:31988 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S129939AbRAEPzM>;
	Fri, 5 Jan 2001 10:55:12 -0500
Message-ID: <3A55EE56.8C1DCDD0@sls.lcs.mit.edu>
Date: Fri, 05 Jan 2001 10:55:02 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54E717.11A43B42@sls.lcs.mit.edu> <3A557D12.A5383794@uow.edu.au> <3A55E15B.F39D6B87@sls.lcs.mit.edu> <3A55EF19.1BD5EE39@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Could you please test this 2.2 driver?
>
>         http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.2.19-pre2-2.gz

Bingo!  This driver works fine.  Thanks.

(Why do hardware people keep tweaking things for seemingly unnecessary reasons?)

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
