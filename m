Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2SLq>; Fri, 29 Dec 2000 13:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2SLg>; Fri, 29 Dec 2000 13:11:36 -0500
Received: from psuvax1.cse.psu.edu ([130.203.4.6]:31677 "HELO mail.cse.psu.edu")
	by vger.kernel.org with SMTP id <S129930AbQL2SLd>;
	Fri, 29 Dec 2000 13:11:33 -0500
From: Coy A Hile <hile@cse.psu.edu>
Message-Id: <200012291741.MAA10090@gorn.cse.psu.edu>
Subject: Re: Problem with ATX halt
To: ryan831@usa.net (Ryan Sizemore)
Date: Fri, 29 Dec 2000 12:41:05 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NEBBIFHONDNEGJDKODONAEIDCDAA.ryan831@usa.net> from "Ryan Sizemore" at Dec 28, 2000 11:59:06 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Sizemore sez....
> 
>    I am new this whole 'posting to the mailing list' thing, so please excuse
> any obvious mistakes.
>    I have a comp. running mandrake 7.2, and when i go to power it down, it
> gives me a screen full of errors, including a stackdump. It happens as the
> very last thing (including being after the file system is unmounted, so I
> highly doubt that the error is recorded somewhere. But i will hand-copy the
> stack for whomever thinks it may be useful. The error is reproduced every
> time, without equivication. Any insight or questions are much apriciated.
> The motherboard is a Soyo 5EMA+ r1.0 w/ ETEQ EQ82C6638 Chipset, and it has
> an Award BIOS.
> Thanks in Advance.
> 

I've seen this before with nearly every Mandrake distrib right out of the
box.  One of the many reasons I choose not to use Mandrake on my personal
boxes.  I think I solved it by recompiling the kernel and taking the 
"Power Management" things out of the kernel.

Coy

--
Coy Hile
hile@cse.psu.edu
"Two roads diverged in a wood, and I-- / I took the one less traveled by, 
And that has made all the difference." --Robert Frost
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
