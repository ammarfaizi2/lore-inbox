Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSKFAkE>; Tue, 5 Nov 2002 19:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSKFAkE>; Tue, 5 Nov 2002 19:40:04 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41481 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265446AbSKFAkC>; Tue, 5 Nov 2002 19:40:02 -0500
Date: Tue, 5 Nov 2002 19:45:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Patrick Finnegan <pat@purdueriots.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
Message-ID: <Pine.LNX.3.96.1021105193917.20035G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Patrick Finnegan wrote:

> > Lota of installations have gtk but don't have qt.
> 
> And a lot of installations have QT but not GTK... This feels like a vi vs
> emacs discussion.

Was this just to cover the possibilities or do you know of such? I guess
all system which build kernels have QT, it won't build without it :-( I
know that's going to be fixed RSN.

> Personally, it makes no difference to me which library is used.  I'm
> doubtful I'll use anything other than menuconfig unless it makes my life a
> *whole* lot easier. I'd say 'choose one and get on with it.'

That's not likely, but perhaps all the groups which have or want a GUI
could define a standard interface which could go in the kernel, and then
any GIU could interpret the metadata from that and display it any way they
want.

Just a thought, I have no axe to grind, menuconfig is the only thing
reasonable to config remote machines. Any GUI over ssh over somewhat slow
open net connections is vastly unproductive.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

