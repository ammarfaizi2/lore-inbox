Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSIOTDx>; Sun, 15 Sep 2002 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSIOTDw>; Sun, 15 Sep 2002 15:03:52 -0400
Received: from dsl-213-023-020-240.arcor-ip.net ([213.23.20.240]:7040 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318207AbSIOTDu>;
	Sun, 15 Sep 2002 15:03:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 21:07:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qejV-00008L-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 20:06, Linus Torvalds wrote:
> On Sun, 15 Sep 2002, Daniel Phillips wrote:
> > 
> > Let's try a different show of hands: How many users would be happier if
> > they knew that kernel developers are using modern techniques to improve
> > the quality of the kernel?
> 
> You're all talk and no action.
> 
> The last time I looked, the people who really _do_ improve the quality of
> the kernel don't tend to care too much about debuggers, or are at least
> capable to add a patch on their own.

Oh sure.  So last week's page release race counts as no action, and htree
is not the fastest directory index in the known universe.  I could go on.
What I do not do is rub people's faces in every little thing I do.  Please
remember who found the last truncate race of the year, just before
2.4.0-prerelease.

> In fact, of the people who opened their mouth about the BUG() issue, how 
> many actually ended up personally _debugging_ the BUG() that we were 
> talking about?

I am personally working on a different problem.

> I did. Matt probably did. But I didn't see you fixing it with your
> debugger.

I am setting up the debugger to work on the DAC960.

> So next time you bring up the kernel debugger issue, show some code and 
> real improvement first. Until then, don't spout off.

You're shooting way wide of the target.

-- 
Daniel
