Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136279AbRAMBwP>; Fri, 12 Jan 2001 20:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136280AbRAMBwF>; Fri, 12 Jan 2001 20:52:05 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:58378
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136279AbRAMBvs>; Fri, 12 Jan 2001 20:51:48 -0500
Date: Fri, 12 Jan 2001 17:51:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: John Heil <kerndev@sc-software.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101121726590.893-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101121749390.2411-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Fri, 12 Jan 2001, Andre Hedrick wrote:
> > 
> > It works perfectly and exactly as it is defined to work by the rules.
> > Getting the rules correct == 'the concept of "working"'.
> 
> Don't be silly.
> 
> You're entirely ignoring the concept of hardware bugs. Which is one very
> likely reason for this whole discussion in the first place.

First you get the access correct and assume no bugs, round one.
After this is fixed, then you address the "hardware bugs" by execption
rules and not the basic premis, the endless round.

Regards,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
