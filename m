Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSDTRR3>; Sat, 20 Apr 2002 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDTRR1>; Sat, 20 Apr 2002 13:17:27 -0400
Received: from dsl-213-023-039-128.arcor-ip.net ([213.23.39.128]:13706 "EHLO
	starship") by vger.kernel.org with ESMTP id <S312980AbSDTRRG>;
	Sat, 20 Apr 2002 13:17:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Fri, 19 Apr 2002 19:17:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Roman Zippel <zippel@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204200942480.11450-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yc0t-0000VL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 18:56, Linus Torvalds wrote:
> On Fri, 19 Apr 2002, Daniel Phillips wrote:
> > 
> > No I do not.  Read the post.  I suggested placing the documentation on
> > kernel.org, on your site, or on bitmover.com where it belongs.
> 
> That was not what your patch did.

Oh, please show me how and I will do it gladly.  I just don't know how to
make diff+patch do that.
 
> > (And there you may have an argument that would satisfy me.  However, it
> > is not me I'm worried about.  It is the other kernel developers who are
> > silently seething at this situation.  Yes they are, use your ears.)
> 
> I would suggest that if you are silently seething about the fact that a 
> commercial product can do something better than a free one,

You got that right.

> how about _doing_ something about it?

However, first I personally do not want to start that project.  Firstly, I
do personally like Larry and do not want to be part of a horde bent on
tearing down his business.  There are after all, plenty of genuinely nasty
things out there to attack, attacking Larry as *way* down my list.  More
importantly, my time is better spent improving Linux.

> Quite frankly, I don't _want_ people using Linux for ideological reasons.  
> I think ideology sucks. This world would be a much better place if people
> had less ideology, and a whole lot more "I do this because it's FUN and
> because others might find it useful, not because I got religion".

That's the point.  It is not fun to see the whole thing start tearing itself
apart.  Fun is being on the winning side.  Fun is not dealing with a lot of
stressed out people with agendas.

> Would I prefer to use a tool that didn't have any restrictions on it for 
> kernel maintenance? Yes. But since no such tool exists, and since I'm 
> personally not very interested in writing one, _and_ since I don't have 
> any hangups about using the right tool for the job, I use BitKeeper.

I use it too.  I do not think it belongs in the tree, especially not with its
own directory.  My point, pure and simple.

> As to why the docs are in the kernel sources rather than on any web-sites:
> it's simply because I don't even _have_ a web page of my own (I've long
> since forgotten the password to my old helsinki.fi account ;), and I have
> absolutely no interest in web page design. So when I got tired of
> explaining how to use BK, I asked Jeff to just send me a patch so that I
> could point people to the only thing I _do_ care about, ie the kernel
> sources.

But did you think it might be controversial?

-- 
Daniel
