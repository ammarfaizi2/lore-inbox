Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRAKVx5>; Thu, 11 Jan 2001 16:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135274AbRAKVxr>; Thu, 11 Jan 2001 16:53:47 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:24076 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135217AbRAKVxi>;
	Thu, 11 Jan 2001 16:53:38 -0500
Date: Thu, 11 Jan 2001 22:53:19 +0100
From: Frank de Lange <frank@unternet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111225319.G3269@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au> <20010111220943.F3269@unternet.org> <3A5E29D4.1AA38368@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5E29D4.1AA38368@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jan 11, 2001 at 04:47:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 04:47:00PM -0500, Jeff Garzik wrote:
> Are you judging based on the error message?  The 'netdev watchdog ...'
> message is a generic error message that could have any number of
> causes.  It's just saying, well, what it says :)  The kernel was unable
> to transmit a packet in a certain amount of time.  You might get these
> messages if you unplug a cable suddenly, or if your hardware isn't
> delivering interrupts, or many other things...

No, I'm judging based on the fact that I found reports from people using
NE2K-PCI with several cards as well as tulip-based cards (different driver) on
abit BP6 as well as Gigabyte motherboards, mostly on 2.3.x/2.4.x kernels. I
found some postings with these problems on 2.2.x kernels.

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
