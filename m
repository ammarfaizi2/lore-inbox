Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293547AbSCKWzP>; Mon, 11 Mar 2002 17:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293749AbSCKWzG>; Mon, 11 Mar 2002 17:55:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293547AbSCKWyq>; Mon, 11 Mar 2002 17:54:46 -0500
Date: Mon, 11 Mar 2002 14:53:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020311234553.A3490@ucw.cz>
Message-ID: <Pine.LNX.4.33.0203111449190.17864-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Mar 2002, Vojtech Pavlik wrote:
> 
> Are you, by any chance, confusing my AMD IDE changes with Pavel Machek's
> first attempt at IDE wake/suspend code?

No, I'm just reacting to alan's email where he mentions the "other goings 
on" - as opposed to your patch which even Alan agreed with.

Note that I've actually tried to read all patches, and right now they are 
all in my tree (of course, the "all" is the Linus kind of "all", which 
only includes the ones I actually _noticed_. 

That includes your AMD IDE driver change _and_ the oh-so-much-discussed
patches by Martin (which in turn included Pavel's change, which - together
with his changelog entry - seems to be the one that triggered the "lively
discussions").

		Linus

