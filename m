Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSA3Apd>; Tue, 29 Jan 2002 19:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287572AbSA3ApZ>; Tue, 29 Jan 2002 19:45:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11784 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287508AbSA3ApM>; Tue, 29 Jan 2002 19:45:12 -0500
Date: Tue, 29 Jan 2002 16:44:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Ricker <kaboom@gatech.edu>
cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.44.0201291719070.24557-100000@verdande.oobleck.net>
Message-ID: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Chris Ricker wrote:
>
> That's fine, but there's a major problem with your scheme.  What happens
> with all the stuff for which no one is listed in MAINTAINERS?

I have to admit that personally I've always found the MAINTAINERS file
more of an irritation than anything else. The first place _I_ tend to look
personally is actually in the source files themselves (although that may
be a false statistic - the kind of people I tend to have to look up aren't
the main maintainers at all, but more single driver people etc).

It might not be a bad idea to just make that "mention maintainer at the
top of the file" the common case.

		Linus

