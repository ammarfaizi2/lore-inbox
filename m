Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSJaSPk>; Thu, 31 Oct 2002 13:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSJaSOs>; Thu, 31 Oct 2002 13:14:48 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:38418 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S262913AbSJaSN5>; Thu, 31 Oct 2002 13:13:57 -0500
Date: Thu, 31 Oct 2002 13:21:27 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310951180.1410-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210311314440.9552-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

>
> On Thu, 31 Oct 2002, Matt D. Robinson wrote:
> >
> > This isn't bloat.  If you want, it can be built as a module, and
> > not as part of your kernel.  How can that be bloat?
>
> I don't care one _whit_ about the size of the binary. I don't maintain
> binaries, adn the binary can be gigabytes for all I care.
>
> The only thing I care about is source code. So the "build it as a module
> and it is not bloat" argument is a total nonsense thing as far as I'm
> concerned.

So, you don't like bloat, such as having 22 different file systems (only
including the ones that can be placed on disk, not things like devfs or
smbfs...). That's more filesystems than I have dollars in my wallet at
the moment.   For the amount of utility that this code provides, it's
definately not 'bloat'.

> Anyway, new code is always bloat to me, unless I see people using them.

HEY!!! WE'RE USING IT!!!

> Guys, why do you even bother trying to convince me? If you are right, you
> will be able to convince other people, and that's the whole point of open
> source.

Now this sounds more like something I'd hear from Sun trying to get a fix
for a version of Solaris without having to buy a new one.  I thought the
whole point of Free Software was sharing with the community, and doing
what's best for the community.

> Being "vendor-driven" is _not_ a bad thing. It only means that _I_ am not
> personally convinced. I'm only one person.

That's the same as claiming that George W. Bush is just one person....

So I'll plea yet again, please add LKCD!

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif



