Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbRAFMOQ>; Sat, 6 Jan 2001 07:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131604AbRAFMOG>; Sat, 6 Jan 2001 07:14:06 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:12764 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131478AbRAFMOC>; Sat, 6 Jan 2001 07:14:02 -0500
Message-ID: <3A570D73.F979ECB6@uow.edu.au>
Date: Sat, 06 Jan 2001 23:20:03 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dchemko@intrinsyc.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x problems on all 2.4 Kernels?
In-Reply-To: <3A56E6FE.6F61A2C4@intrinsyc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Chemko wrote:
> 
> I am using a 3Com 905C Tornado Vortex Driver and the official 2.4.0, and
> the driver does not start up. I think I had the same problem with this
> driver in the 2.2 kernel, which forced me to use 3com's 3c90x, which is
> not available for 2.4. Below are the specs:
> 

Presumably this is a new NIC?  Marked 3c905CX?

Could you please test the driver at

	http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.4.0-1.gz

and let me know?

Thanks

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
