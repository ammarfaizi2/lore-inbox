Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTFTQpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFTQpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:45:31 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:39672 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263375AbTFTQpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:45:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Larry McVoy <lm@bitmover.com>, Nick LeRoy <nleroy@cs.wisc.edu>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Fri, 20 Jun 2003 11:58:39 -0500
X-Mailer: KMail [version 1.2]
Cc: Larry McVoy <lm@bitmover.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Werner Almesberger <wa@almesberger.net>, miquels@cistron-office.nl,
       linux-kernel@vger.kernel.org
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <200306200944.05937.nleroy@cs.wisc.edu> <20030620151750.GA17563@work.bitmover.com>
In-Reply-To: <20030620151750.GA17563@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <03062011583901.27684@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 June 2003 10:17, Larry McVoy wrote:
> On Fri, Jun 20, 2003 at 09:44:05AM -0500, Nick LeRoy wrote:
> > You sight the Linux kernel as non-inovative, essentially.  I'll certainly
> > grant that the general idea of a Unix kernel is not original work, and
> > that most of the concepts from which Linux is derived are well known.  I
> > also take issue with the idea that there's _nothing_ innovative about LK,
> > but I'm
>
> I knew I would be taken to task on that point.  Remember, I'm a big fan of
> Linux, I've been here forever and tried to help where I could.  I thought
> about what is new in Linux and couldn't come up with much.  /proc is a
> hell of a lot nicer than /proc in solaris, it's not really /proc, it's
> /system and there was a Usenix paper about /system long ago.  clone(2) is
> clone but it's basically plan 9's rfork (though I like how the code
> works in Linux somewhat better, it's really clean).
>
> One thing that is "new" is a passion for keeping the kernel fast with a
> lean system call layer.  I _love_ that part of Linux, it may seem subtle,
> but Linux is really the only operating system where you can use the OS
> level services as if they were library calls and not really notice that you
> are going into to the kernel.  That's very cool and you could say it is new
> in terms of cleanliness and discipline.

Uhhh that is 20 years old... the original MULTICs had that.

[snip]
>
> > Sendmail, very much open source, was certainly ground-breaking.  The X
> > window system.  Nethack, adventure, etc. -- the whole concept of computer
> > gaming derives from the open source world (granted the is all from long
> > before the term "open source" existsed).
>
> The stuff you are describing is 20 years old.  The problem I'm describing
> is current.

And you think there have been no improvements? Think about windows... 10 years
to get NT4... and no real improvement there.

>
> Maybe this is a way to see the point:  Red Hat, which is a company I like
> and I have friends there so I'm not trying to beat up on them OK?, has been
> around for quite a while.  They are an open source company.  I'm not sure
> how old they are but it has to be more than 5 years, right?  Wouldn't it
> be interesting to go compare what Red Hat has done in terms of new stuff
> to say, Sun, in the same first N years of their history?  I'd have to go
> look at the timelines but Sun brought us mmap(), the VFS layer, NFS, RPC,
> yp, etc.  And wrote nice thoughtful papers about it all so that others
> could learn from their efforts.

I was using a "VFS" layer way before Linux existed... Look at the old PDP-10
tops-10 system for a first draft (that I used, there may have been others).
When DEC released RSX11 all filesystems were under a form of virtual 
filesystem. Tapes, disks, and later networks and network filesystems.

Even microkernel systems existed in 1971.. though they weren't called that.
The RSX11 kernel only handled memory management and system calls. Everything
else was handed off to a privileged user mode task (disk drivers, file
systems, even some system calls).

The big innovation going on in linux is being able to learn from others
mistakes, then doing it better.

Propriatary software/IP doesn't let you do that, so you are stuck in a rut.

No improvements, no innovation.

