Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262051AbSJHLqM>; Tue, 8 Oct 2002 07:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbSJHLqM>; Tue, 8 Oct 2002 07:46:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262051AbSJHLqL>; Tue, 8 Oct 2002 07:46:11 -0400
Date: Tue, 8 Oct 2002 07:53:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jbradford@dial.pipex.com
cc: simon@baydel.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
In-Reply-To: <200210081111.g98BBFfv010140@darkstar.example.net>
Message-ID: <Pine.LNX.3.95.1021008074333.5870A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002 jbradford@dial.pipex.com wrote:

> > These modules again drive gate array hardware for which nobody 
> > else will ever have a compatible. Although I would dearly love to 
> > use Linux as the platform for my project I feel I cannot release this 
> > code under the GPL.
> 
> That just doesn't make sense.  If nobody else will ever have a
> compatible piece of hardware, I don't see why you wouldn't want to
> release the driver code under the GPL.
> 
> _Unless_ you fear that somebody will derive your hardware design from
> the code.  Is that what you're worried about?
> 
> John.

Maybe he's afraid that customers will see that the hardware design is
absolute garbage with thousands of defective-hardware-work-arounds in
software. If so, don't worry! I don't think there is a piece of digital
hardware remaining on the planet that doesn't require software playing
nurse-maid. And everybody knows that if a decision has to be made to
re-do a PWB at $150,000 a pop, or to invent some software work-arounds,
the work-arounds will always win. Besides, software is "free". Once it's
done and the software engineers laid-off, you just clone in over-and-over
again. Ask any production manager.

I know of a company that has WOM (Write Only Memory) right in the
middle of some RAM address space. Guess what? It's memory-mapped and
'owned' by some sleeping giant!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

