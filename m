Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRAEENY>; Thu, 4 Jan 2001 23:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131529AbRAEENO>; Thu, 4 Jan 2001 23:13:14 -0500
Received: from ace.ulyssis.student.kuleuven.ac.be ([193.190.253.36]:49937 "EHLO
	ace.ulyssis.org") by vger.kernel.org with ESMTP id <S131375AbRAEEM5>;
	Thu, 4 Jan 2001 23:12:57 -0500
Date: Fri, 5 Jan 2001 05:12:36 +0100 (CET)
From: Chipzz <chipzz@ULYSSIS.Org>
Reply-To: Chipzz@ULYSSIS.Org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <E14EEr4-000697-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0101050509090.11080-100000@ace>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Alan Cox wrote:

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Subject: Re: Journaling: Surviving or allowing unclean shutdown?
> 
> > in an enbedded device you can
> > 1. setup the power switch so it doesn't actually turn things off (it
> > issues the shutdown command instead)
> 
> Costs too much money

I have an old IBM Aptiva 486 SX that actually DOES something like this; what
it does is, it suspends to disk when you hit the power button (you have to
turn that option on though).
I once actually had a situation where a badly behaved application prevented
this suspend-to-disk, and I had to pull the plug.
Point being, if it was possible back then (6 years ago), why on earth would
it be too expensive now?

Greetings,

Chipzz AKA
Jan Van Buggenhout
-- 

--------------------------------------------------------------------------
                  UNIX isn't dead - It just smells funny
                            Chipzz@ULYSSIS.Org
--------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
