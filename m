Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSIOQfl>; Sun, 15 Sep 2002 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSIOQfl>; Sun, 15 Sep 2002 12:35:41 -0400
Received: from dsl-213-023-039-078.arcor-ip.net ([213.23.39.78]:29313 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318085AbSIOQfl>;
	Sun, 15 Sep 2002 12:35:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Daniel Berlin <dberlin@dberlin.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 18:41:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209150118220.25197-100000@dberlin.org>
In-Reply-To: <Pine.LNX.4.44.0209150118220.25197-100000@dberlin.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qcT1-0000D7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 07:33, Daniel Berlin wrote:
> On Sun, 15 Sep 2002, Daniel Phillips wrote:
> > It's getting more
> > popular, and it would be more popular yet if it weren't considered some
> > dirty little secret, or somehow unmanly.
> 
> Reminds me of "Suns boot fast" (do a google search on it, and read the 
> first thing that comes up).

Yes.  Using a really nice development environment is an "aha" experience.
You can listen to people talk about it as much as you want, but if you
have never actually used one you will never really understand what
they're talking about, and why they get worked up about it.

Linux is WAY WAY far from being a really nice development environment.
It's really nice in many other ways, but not in that way.

For example, there is no excuse for ever needing more than 1/4 second
to get from the function you're looking at on the screen to its
definition and source text, ready to read or edit.

There's no excuse for having to copy down an oops from a screen by
hand, either.  It's nice to know you can fall back to this if you have
to, but having that be the default way of working is just broken.

There's no excuse for having to pepper low level code with printk's
to bracket a simple segfault.

OK, I'll stop there.  Actually, the only thing I'm really irritated
about at the moment is the attitude of people who should know better,
promoting the fiction that this veggie-zen-tools-made-out-of-wood
thing is actually helping the kernel progress faster.

I suppose I'm going about this the wrong way, since directly pointing
out wrong-headed thinking usually just causes a defensive reaction
and puts people in a position where they're reluctant to back down
for fear of losing karma.  Well, then.  Listen to Andrew.  He knows
whereof he speaks, and plus he's nice about it, unlike me.

-- 
Daniel
