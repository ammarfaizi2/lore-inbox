Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136135AbRAMBeB>; Fri, 12 Jan 2001 20:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136155AbRAMBdw>; Fri, 12 Jan 2001 20:33:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16658 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136135AbRAMBdi>; Fri, 12 Jan 2001 20:33:38 -0500
Date: Fri, 12 Jan 2001 17:31:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: John Heil <kerndev@sc-software.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101121719480.2411-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10101121726590.893-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Andre Hedrick wrote:
> 
> It works perfectly and exactly as it is defined to work by the rules.
> Getting the rules correct == 'the concept of "working"'.

Don't be silly.

You're entirely ignoring the concept of hardware bugs. Which is one very
likely reason for this whole discussion in the first place.

ANYBODY who does driver development without taking the real world into
account is a dangerous person. Stacks of papers, diagrams and rules are
absolutely WORTHLESS if you can't just understand the fact that
documentation is nothing more than a guide-line.

Once you realize that documentation should be laughed at, peed upon, put
on fire, and just ridiculed in general, THEN, and only then, have you
reached the level where you can safely read it and try to use it to
actually implement a driver.

I'm continually amazed and absolutely scared silly by your blind trust in
paperwork, whether it be standards or committees or vendor documentation.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
