Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135594AbRAJOVu>; Wed, 10 Jan 2001 09:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135645AbRAJOVm>; Wed, 10 Jan 2001 09:21:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2835 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135594AbRAJOVW>; Wed, 10 Jan 2001 09:21:22 -0500
Subject: Re: 2.4.0 umount problem
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 10 Jan 2001 14:22:30 +0000 (GMT)
Cc: hyponephele@hotmail.com (M T), linux-kernel@vger.kernel.org
In-Reply-To: <31178.979125106@ocs3.ocs-net> from "Keith Owens" at Jan 10, 2001 10:11:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GM93-0000L1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >shutting system down with kernel-2.4.0. I get message that "/ device is 
> >busy".
> 
> Known problem with Redhat 6.2 scripts.  Ask Redhat for the fix.

Are you sure its that. I was seeing this with one box in 2.4.0 but I don't see
it in -ac. (No I dont know why either). Even better do you know which script so
I can work out why

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
