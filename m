Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314659AbSDTQ4u>; Sat, 20 Apr 2002 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314660AbSDTQ4u>; Sat, 20 Apr 2002 12:56:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314659AbSDTQ4p>; Sat, 20 Apr 2002 12:56:45 -0400
Date: Sat, 20 Apr 2002 09:56:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jeff Garzik <garzik@havoc.gtf.org>, Roman Zippel <zippel@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16ybKQ-0000U9-00@starship>
Message-ID: <Pine.LNX.4.33.0204200942480.11450-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Apr 2002, Daniel Phillips wrote:
> 
> No I do not.  Read the post.  I suggested placing the documentation on
> kernel.org, on your site, or on bitmover.com where it belongs.

That was not what your patch did.

> (And there you may have an argument that would satisfy me.  However, it
> is not me I'm worried about.  It is the other kernel developers who are
> silently seething at this situation.  Yes they are, use your ears.)

I would suggest that if you are silently seething about the fact that a 
commercial product can do something better than a free one, how about 
_doing_ something about it?

Quite frankly, I don't _want_ people using Linux for ideological reasons.  
I think ideology sucks. This world would be a much better place if people
had less ideology, and a whole lot more "I do this because it's FUN and
because others might find it useful, not because I got religion".

Would I prefer to use a tool that didn't have any restrictions on it for 
kernel maintenance? Yes. But since no such tool exists, and since I'm 
personally not very interested in writing one, _and_ since I don't have 
any hangups about using the right tool for the job, I use BitKeeper.

As to why the docs are in the kernel sources rather than on any web-sites:
it's simply because I don't even _have_ a web page of my own (I've long
since forgotten the password to my old helsinki.fi account ;), and I have
absolutely no interest in web page design. So when I got tired of
explaining how to use BK, I asked Jeff to just send me a patch so that I
could point people to the only thing I _do_ care about, ie the kernel
sources.

		Linus

