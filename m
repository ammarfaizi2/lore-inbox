Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbRFKQih>; Mon, 11 Jun 2001 12:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRFKQi1>; Mon, 11 Jun 2001 12:38:27 -0400
Received: from web3503.mail.yahoo.com ([216.115.111.70]:45329 "HELO
	web3503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261979AbRFKQiP>; Mon, 11 Jun 2001 12:38:15 -0400
Message-ID: <20010611163813.24181.qmail@web3503.mail.yahoo.com>
Date: Mon, 11 Jun 2001 17:38:13 +0100 (BST)
From: =?iso-8859-1?q?Mich=E8l=20Alexandre=20Salim?= 
	<salimma1@yahoo.co.uk>
Subject: Follow-up: Re: Clock drift on Transmeta Crusoe (Sony Vaio C1VE)
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106111540290.24179-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to be a rather common problem and probably that
is why only Mark Hahn has replied so far, but
searching through Google most other computers seem to
get a clock drift of only 1 minute per day at worst,
and I have consistently seen my system clock doing 4
minutes a day slower than its hardware clock, my other
PC and my VCR.

This is rather odd, has anyone experienced anything
like this on the Vaio Crusoe before?

Regards,

Michel
--- Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
wrote: > > It is .. 32-bit I/O, multimode turned on,
> read-ahead,
> > DMA on. Does it affect the system clock in any
> way?
> 
> none of the rest matters as long as dma is on.  the
> issue 
> is whether other irq-handling interferes with
> handling the 
> system clock tick.  but I had the impression that
> crusoe
> provided TSC, or something like it.  didn't you say
> your problem only happens when compiled for notsc
> (386)?
> 


____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
