Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTLLPjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLLPjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:39:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33809 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265253AbTLLPjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:39:31 -0500
Date: Fri, 12 Dec 2003 10:27:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Craig Milo Rogers <rogers@isi.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031212113650.GB12727@mail.shareable.org>
Message-ID: <Pine.LNX.3.96.1031212102151.9808E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Jamie Lokier wrote:

> Craig Milo Rogers wrote:
> > On 03.12.09, bill davidsen wrote:

> > > Well, the addresses and offset specs came from *somewhere*, and I would
> > > love to hear someone argue that they "just seemed like good values," or
> > > that reading the header file and then using absolute numbers isn't
> > > derivative.
> 
> Using the absolute numbers and/or structures (i.e. the interface)
> needed to progam a device seems like a fine example of fair use, even
> when the header file containing them is copyrighted.
> 
> Fair use trumps derivation.
> 
> > 	INAL.  Observable facts (such as absolute numbers) aren't
> > derivative (in the U.S.) because there's no "creativity"***.  See the
> > famous court decision (... web search ...)  "Feist Publications
> > v. Rural Telephone Serv. Co.", for example.  Of course, the DCMA (or
> > other fell beasts) may have superseded that legal doctrine.
> 
> I guess a hardware manufacturer who feels their programming
> information is worth keeping secret may well argue that they _chose_
> the numbers that needed to be fed to their device, and thus they're creative.
> 
> But that's silly, and we're in deep shit if ever that argument is
> taken seriously because _lots_ of Linux and BSD open source drivers
> were developed by studying the behaviour or code of another driver.

After thinking about this, and why this would be allowed if disassembly or
reverse engineering Windows drivers is (in some cases) prohibited, I
conclude that the license on the drivers prohibits such reverse
engineering.

Taking that one step farther, could the license on the moduling ABI be
changed, not requiring consent of everyone with code in the kernel just
the designer of the ABI, to prohibit using it for binary-only modules? Did
Rusty redo this when he attacked the module code? Is there a lawyer in the
house?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

