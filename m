Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278871AbRJ1XLH>; Sun, 28 Oct 2001 18:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278868AbRJ1XKr>; Sun, 28 Oct 2001 18:10:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:182 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278867AbRJ1XKj>;
	Sun, 28 Oct 2001 18:10:39 -0500
Date: Sun, 28 Oct 2001 18:11:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@atnf.csiro.au>
cc: Rik van Riel <riel@conectiva.com.br>,
        Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <200110282231.f9SMV9U26740@mobilix.atnf.CSIRO.AU>
Message-ID: <Pine.GSO.4.21.0110281745140.24880-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Oct 2001, Richard Gooch wrote:

> Alexander Viro writes:
> > So far all I see is that beating you hard enough in public can make
> > you fix the bugs explicitly pointed to you.  That's it.  As far as I
> > can see you don't read your own code, judging by the fact that every
> > damn look at fs/devfs/base.c shows a new hole within a couple of
> > minutes _and_ said holes stay until posted on l-k.  Private mail
> > doesn't work.  You read it, reply and ignore.  About hundred
                       ^^^^^^^^^^^^^^^^^^^^^^^^^
> > kilobytes of evidence available at request.
>
> You don't get to see the bug reports or questions I respond to which
> are sent to me privately or on the devfs list (I know you're not
> subscribed:-). And you seem to have forgotten that I've responded to
> questions or bug reports *from you* that you send privately to me,

I see what made its way in your code and your changelog.  As far as I
can see nothing contradicts description above.
 
1) You are maintainer of that code.
2) Couple of minutes of reading through it is enough to find a new hole.
3) There are dozens of such holes.
4) They had been there for years.

Conclusion:

You either can't see that stuff at all or you don't bother to spend even
minimal time looking for bugs.

See the problem with that situation?


