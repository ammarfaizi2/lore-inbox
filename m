Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbSJFTnz>; Sun, 6 Oct 2002 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262169AbSJFTnx>; Sun, 6 Oct 2002 15:43:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31708 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262168AbSJFTnw>;
	Sun, 6 Oct 2002 15:43:52 -0400
Date: Sun, 6 Oct 2002 22:00:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Ulrich Drepper <drepper@redhat.com>, <bcollins@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK MetaData License Problem?
In-Reply-To: <Pine.LNX.4.44.0210061236400.10069-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210062157550.14408-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Linus Torvalds wrote:

> If this is a concern, it actually appears that BK has the capability to
> "enforce" a license, in that I coul dmake BK aware of the GPL and that
> would cause BK to pop up a window saying "Do you agree to this license"  
> before the first check-in by a person (the same way it asked you whether
> you wanted to allow openlogging).

sounds interesting - is it difficult to enabled it, just to see how much
impact it has on daily work?

> Do people feel that would be a good idea? I actually dismissed it when
> Larry talked about it, because I felt people might take it as another
> "too much BK in your face", even though the license would be the _Linux_
> license, not the BK one.

well, if it can be made a one-time thing, ie. something like: 'from now on
if you commit in the repository and distribute the changes then all those
changes and related BK metadata are licensed under the GPL', that would be
less intrusive i guess?

	Ingo

