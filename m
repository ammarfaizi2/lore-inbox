Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbRAEP5p>; Fri, 5 Jan 2001 10:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132291AbRAEP5f>; Fri, 5 Jan 2001 10:57:35 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:4536 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129744AbRAEP5Z>; Fri, 5 Jan 2001 10:57:25 -0500
Message-ID: <3A55F047.1F41A6FC@uow.edu.au>
Date: Sat, 06 Jan 2001 03:03:19 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: I Lee Hetherington <ilh@sls.lcs.mit.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54E717.11A43B42@sls.lcs.mit.edu> <3A557D12.A5383794@uow.edu.au> <3A55E15B.F39D6B87@sls.lcs.mit.edu> <3A55EF19.1BD5EE39@uow.edu.au> <3A55EE56.8C1DCDD0@sls.lcs.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Lee Hetherington wrote:
> 
> Andrew Morton wrote:
> 
> > Could you please test this 2.2 driver?
> >
> >         http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.2.19-pre2-2.gz
> 
> Bingo!  This driver works fine.  Thanks.

And /proc/interrupts?

> (Why do hardware people keep tweaking things for seemingly unnecessary reasons?)

They hate software people.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
