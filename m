Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283048AbRLQXTn>; Mon, 17 Dec 2001 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbRLQXTc>; Mon, 17 Dec 2001 18:19:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283048AbRLQXTY>; Mon, 17 Dec 2001 18:19:24 -0500
Date: Mon, 17 Dec 2001 15:18:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.40.0112171508330.1577-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0112171516090.1891-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Davide Libenzi wrote:
> >
> > You have to prioritize. Scheduling overhead is way down the list.
>
> You don't really have to serialize/prioritize, old Latins used to say
> "Divide Et Impera" ;)

Well, you explicitly _asked_ me why I had been silent on the issue. I told
you.

I also told you that I thought it wasn't that big of a deal, and that
patches already exist.

So I'm letting the patches fight it out among the people who _do_ care.

Then, eventually, I'll do something about it, when we have a winner.

If that isn't "Divide et Impera", I don't know _what_ is. Remember: the
romans didn't much care for their subjects. They just wanted the glory,
and the taxes.

		Linus

