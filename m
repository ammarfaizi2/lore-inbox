Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTFTPEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 11:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTFTPEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 11:04:07 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19919 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263163AbTFTPED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 11:04:03 -0400
Date: Fri, 20 Jun 2003 08:17:50 -0700
From: Larry McVoy <lm@bitmover.com>
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: Larry McVoy <lm@bitmover.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Werner Almesberger <wa@almesberger.net>, miquels@cistron-office.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Message-ID: <20030620151750.GA17563@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nick LeRoy <nleroy@cs.wisc.edu>, Larry McVoy <lm@bitmover.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Werner Almesberger <wa@almesberger.net>, miquels@cistron-office.nl,
	linux-kernel@vger.kernel.org
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <20030620120910.3f2cb001.skraw@ithnet.com> <20030620142436.GB14404@work.bitmover.com> <200306200944.05937.nleroy@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306200944.05937.nleroy@cs.wisc.edu>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 09:44:05AM -0500, Nick LeRoy wrote:
> You sight the Linux kernel as non-inovative, essentially.  I'll certainly 
> grant that the general idea of a Unix kernel is not original work, and that 
> most of the concepts from which Linux is derived are well known.  I also take 
> issue with the idea that there's _nothing_ innovative about LK, but I'm

I knew I would be taken to task on that point.  Remember, I'm a big fan of 
Linux, I've been here forever and tried to help where I could.  I thought 
about what is new in Linux and couldn't come up with much.  /proc is a
hell of a lot nicer than /proc in solaris, it's not really /proc, it's
/system and there was a Usenix paper about /system long ago.  clone(2) is
clone but it's basically plan 9's rfork (though I like how the code 
works in Linux somewhat better, it's really clean).  

One thing that is "new" is a passion for keeping the kernel fast with a lean
system call layer.  I _love_ that part of Linux, it may seem subtle, but
Linux is really the only operating system where you can use the OS level
services as if they were library calls and not really notice that you are
going into to the kernel.  That's very cool and you could say it is new
in terms of cleanliness and discipline.  

I'm definitely not trying to say Linux is bad, quite the opposite.
Linux rocks, I'll fight to keep it healthy and in fact that's why I
rattle the cages once in a while.

I think the most profound new things in Linux are Linus himself, he's a
unique leader IMO, and even moreso the process by which it is developed.
The *process* is new, at least new to the commercial world.  It's too
bad that the community couldn't patent the development process :)  Most
commercial folks who come in contact with the Linux development process
just don't get it, they want to impose "control" and "release process"
and all sorts of stuff that makes sense in a commercial environment but
would ruin what's going on with Linux.  The BSD folks are much closer to
commercial people in mentality, they want that feeling of control and 
Linux is developed in a sort of zen like free for all that is different
and works well.

> Sendmail, very much open source, was certainly ground-breaking.  The X window 
> system.  Nethack, adventure, etc. -- the whole concept of computer gaming 
> derives from the open source world (granted the is all from long before the 
> term "open source" existsed).

The stuff you are describing is 20 years old.  The problem I'm describing
is current.

Maybe this is a way to see the point:  Red Hat, which is a company I like
and I have friends there so I'm not trying to beat up on them OK?, has been
around for quite a while.  They are an open source company.  I'm not sure
how old they are but it has to be more than 5 years, right?  Wouldn't it
be interesting to go compare what Red Hat has done in terms of new stuff
to say, Sun, in the same first N years of their history?  I'd have to go 
look at the timelines but Sun brought us mmap(), the VFS layer, NFS, RPC,
yp, etc.  And wrote nice thoughtful papers about it all so that others 
could learn from their efforts.

> Hope we're still friends....

Absolutely.  I know my views are not widely held and they piss people off.
Sorry about that, it's not my goal to piss anyone off, it's my goal to get
people to look farther out into the future and try and plan for it.

Cheers,
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
