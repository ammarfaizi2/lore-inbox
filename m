Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262466AbSJHMCa>; Tue, 8 Oct 2002 08:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbSJHMCa>; Tue, 8 Oct 2002 08:02:30 -0400
Received: from 62-190-216-115.pdu.pipex.net ([62.190.216.115]:30982 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262466AbSJHMC3>; Tue, 8 Oct 2002 08:02:29 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210081209.g98C9vlm010422@darkstar.example.net>
Subject: Re: The end of embedded Linux?
To: root@chaos.analogic.com
Date: Tue, 8 Oct 2002 13:09:57 +0100 (BST)
Cc: simon@baydel.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1021008074333.5870A-100000@chaos.analogic.com> from "Richard B. Johnson" at Oct 08, 2002 07:53:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > These modules again drive gate array hardware for which nobody 
> > > else will ever have a compatible. Although I would dearly love to 
> > > use Linux as the platform for my project I feel I cannot release this 
> > > code under the GPL.
> > 
> > That just doesn't make sense.  If nobody else will ever have a
> > compatible piece of hardware, I don't see why you wouldn't want to
> > release the driver code under the GPL.
> > 
> > _Unless_ you fear that somebody will derive your hardware design from
> > the code.  Is that what you're worried about?
> > 
> > John.
> 
> Maybe he's afraid that customers will see that the hardware design is
> absolute garbage with thousands of defective-hardware-work-arounds in
> software. If so, don't worry!

Exactly, the customers are not going to read the source code and
refuse to buy his product.  After all, people buy software modems :-).

> I know of a company that has WOM (Write Only Memory) right in the
> middle of some RAM address space. Guess what? It's memory-mapped and
> 'owned' by some sleeping giant!

Have you seen the spec sheet for a WOM that was published, (I think on
1st April), a long time ago?  It had specs like VDD 0v +/- 2% :-)

John.
