Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbTAIRm2>; Thu, 9 Jan 2003 12:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTAIRm2>; Thu, 9 Jan 2003 12:42:28 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:5836 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S266928AbTAIRmX> convert rfc822-to-8bit; Thu, 9 Jan 2003 12:42:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: root@chaos.analogic.com, vlad@geekizoid.com
Subject: Re: What's in a name?
Date: Thu, 9 Jan 2003 11:48:10 -0600
User-Agent: KMail/1.4.1
Cc: "'John Alvord'" <jalvo@mbay.net>, linux-kernel@vger.kernel.org,
       rms@gnu.org
References: <Pine.LNX.3.95.1030109110746.10873A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030109110746.10873A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301091148.10214.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 January 2003 10:11 am, Richard B. Johnson wrote:
> On Thu, 9 Jan 2003, Vlad@Vlad.geekizoid.com wrote:
> > And in that same period, look at Linux, and then look at Hurd.  Hurd even
> > has the advantage of using giant chunks of Linux code, but it still is
> > basically useless.
> >
> > Why should Linux be refered to as GNU/Linux because of tools, and yet
> > Hurd doesn't give credit where credit is due?  RMS has done more to hurt
> > GNU with his current stance on the matter than Microsoft ever could. 
> > He's getting annoying, too.
> >
> > Regards,
> > Scott
>
> Damn. This is getting tried and it doesn't seem to "go away".
>
> Anybody remember this Copyright notice??  Most ALL of the
> early Linux Distributions contained programs with this
> notice:
>
> /*
>  * Copyright (c) 1983 Regents of the University of California.
>  * All rights reserved.
>  *
>  * Redistribution and use in source and binary forms are permitted
>  * provided that the above copyright notice and this paragraph are
>  * duplicated in all such forms and that any documentation,
>  * advertising materials, and other materials related to such
>  * distribution and use acknowledge that the software was developed
>  * by the University of California, Berkeley.  The name of the
>  * University may not be used to endorse or promote products derived
>  * from this software without specific prior written permission.
>  * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
>  * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
>  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
>  */
>
> #ifndef lint
> char copyright[] =
> "@(#) Copyright (c) 1983 Regents of the University of California.\n\
>  All rights reserved.\n";
> #endif /* not lint */
>
>
> ...however.  Something happened so that this code was lifted
> "whole cloth" into some later distributions that contained
> the GNU License notice. By some unknown mystery, the embeded
> copyright notice was eliminated as well. However, much of the
> code remained the same. In some little-used programs, all the
> code, including the bug, remained the same.
>
> If I had anything to do with so-called GNU, I'd keep my mouth
> shut so this wholesale appropriation of intellectual property
> was not investigated.
>
> Here is an early distribution of Linux:
>
> Script started on Thu Jan  9 10:55:02 2003
> # cd /usr/bin
> # strings * | grep Regents
> @(#) Copyright (c) 1980 Regents of the University of California.
> @(#) Copyright (c) 1980 The Regents of the University of California.
[snip]
> @(#) Copyright (c) 1991 The Regents of the University of California.
> # cd /sbin
> # strings * | grep Regents
> strings: control: No such file or directory
> strings: discard: No such file or directory
> The Regents of the University of California.  All rights reserved.
> The Regents of the University of California.  All rights reserved.
> The Regents of the University of California.  All rights reserved.
> The Regents of the University of California.  All rights reserved.
> strings: server: No such file or directory
> The Regents of the University of California.  All rights reserved.
> strings: sysinit: No such file or directory
> # exit
> Script done on Thu Jan  9 10:57:53 2003
>
>
> So much for the absolute bullshit that GNU started Linux and that
> there is somehow a GNU/Linux.  Most all of the early distributions
> used programs ported from BSD. The Linux-BSD emulation was so good,
> thanks to Linus and others, that most programs needed to only be
> recompiled.
>
> That, ladies and gentlemen, is the true history of the "Linux Operating
> System" with all of the components that RMS insists are his, actually
> coming from the University of California, Berkeley.
>
> Don't be bambozzled by the persons who will re-write history to glorify
> their accomplishments. Saying something over-and-over again doesn't
> make it true. Facts stand alone. They only need to be noted. Bullshit
> needs repeating.

I seem to remember that there was also a request from the University of 
California to remove that code too. That was when they started charging
for the BSD distribution, and before the NetBSD got out, which also
had to rewrite/replace the code. Guess what got used...

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
