Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSA3Cz1>; Tue, 29 Jan 2002 21:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288188AbSA3CzR>; Tue, 29 Jan 2002 21:55:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288288AbSA3CzE>; Tue, 29 Jan 2002 21:55:04 -0500
Date: Tue, 29 Jan 2002 18:54:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Ricker <kaboom@gatech.edu>
cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.44.0201291938530.26901-100000@verdande.oobleck.net>
Message-ID: <Pine.LNX.4.33.0201291851270.1766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Chris Ricker wrote:
>
> We're agreed that the files themselves are the best indicator of where to
> route patches, and that MAINTAINERS isn't useful for much besides deciding
> who should get IPO offers ;-).  What I'm wondering is where I, as someone
> who is listed in some of the Documentation/* stuff as its maintainer, should
> be sending patches.  You want a hierarchy, and I think that's perfectly
> reasonable, but I have no idea who the layer of the hierarchy between me and
> you is....

Ahh..

I had the same problem with Documentation/Configure.help, as you saw.

My solution in that case (when the issue came to a flame-fest) was to just
split up the documentation - which makes it a whole lot more maintainable
for everybody, and also makes it fairly explicit who maintains it for most
cases.

Basically, I'd really like documentation to go with the thing it
documents. This is something where the docbook stuff helped noticeably.

			Linus

