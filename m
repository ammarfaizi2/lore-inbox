Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSEZD6P>; Sat, 25 May 2002 23:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSEZD6O>; Sat, 25 May 2002 23:58:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17368 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315630AbSEZD6N>;
	Sat, 25 May 2002 23:58:13 -0400
Date: Sat, 25 May 2002 23:58:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020525201749.A19792@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0205252320550.15165-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Larry McVoy wrote:

> Good luck making that stick in court.  First of all, the RTAI guys have
> admitted over and over that RTAI is a fork of the RTLinux source base.
> Your claims that that isn't true are countered by principles from both
> parties in question.  Second of all, both source bases have evolved 
> since the fork.  Whether your script catches the common heritage or 
> not has no meaning, the fact remains that one is derived from the
> other, and as such has to be GPLed.

Larry, can it.  4.4BSD was derived from v6->v7->32V - nobody had ever
denied that.  So was USG "codebase"<spit>.  Didn't change the outcome
of lawsuit.

And for fuck sake, stop harping on "GPL is the only free license, anyone
who prefers something else wants to use code as revenue source" tune - 
$DEITY witness, FSF wankers are more than enough.  It was my impression
that unlike them you _do_ pretend to have some amount of intellectual honesty.

For the record - the only reason why I'm using GPL for kernel work is
the license on the rest of kernel.  My preference for situations when
I get to choose is either BSD license (short one) or Artistic - _not_ GPV,
thank you very much.  For very simple reasons - I don't care who uses
the code and don't think that forcing contributions works better than
letting people contribute if they want to do that.

If somebody chooses to use these "free for GPLed works" patents - fine,
but at least have a decency to admit that it's a bit more complex than
"if you want to make money on my work I want a part of it".

I don't give a damn for RT systems in general and RTLinux/RTAI in particular,
but I'm getting really sick and tired from the density of crap in this thread.
Folks, it stinks.  On both sides.

Grrr... As if dealing with "product" of Sun-employed cretins was not enough
interactions with idiocy for one day...

