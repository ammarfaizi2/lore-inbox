Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316643AbSE1OhH>; Tue, 28 May 2002 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSE1OhG>; Tue, 28 May 2002 10:37:06 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:3338 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316643AbSE1OhF>; Tue, 28 May 2002 10:37:05 -0400
Date: Tue, 28 May 2002 16:37:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: yodaiken@fsmlabs.com
cc: linux-kernel@vger.kernel.org
Subject: Re: A reply on the RTLinux discussion.
In-Reply-To: <20020528060406.A18344@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.21.0205281522050.17583-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 28 May 2002 yodaiken@fsmlabs.com wrote:

> 	Our resellers and OEM partners include some of the most serious
> 	players in the embedded Linux business:  LynuxWorks, RedSonic, and
> 	Red Hat. 

I looked at the Red Hat site and didn't found a single mention of RTLinux.

> 	There are also some issues particular to RTAI technology and 
> 	support that we believe will put off adopters: an API in flux,
> 	no solid commercial support, stability issues and so on.

Oh, the usual open source myth, how original... :-(

> 	The patent license is absolutely clear: GPL software can
> 	use the patented method without payment of any fee.

It is absolutely not clear and I already explained why.
>From your statements it's obvious that you mean some sort of "free for
noncommercial use" license. Why don't you say it like that? I think there
enough of such licenses, which you can use an example. Maybe there would
be then a small problem, that you would be in violation of the GPL and you
couldn't freely use the work of others for your product?
Especially if I see sentences like "If you distribute your software or
market your software through some web site [..], you must make source code
for the software [..] immediately available on the World-Wide-Web for all
to access.", it says to me that you actually mean "Do all your work for
free or pay". Such a requirement goes even further than even the GPL
requires.
(Should I mention that your license had even worse problems in the past?)

> 	it would still not be
> 	permitted to link binary modules into the derived program without
> 	our permission.  RTAI "user space"  to me, does not escape this
> 	issue. 

AFAIK the patent doesn't give you the right to forbid anyone from using
the technology, you only have a right to demand a compensation. If I am
correct with this, you are possibly violating the GPL here. The binary
module exception is an additional right granted to you by Linus, which
you can't simply deny to others. The user space issue is even more clear,
because that is clearly defined.
While we are at copyright violations, I was browsing your web site and I'm
curious why you sell a separate binary UP and SMP version, wouldn't it be
just enough to recompile the kernel and the modules? Are the additional
4000$ for the source version your definition of "cost of physically
performing source distribution"?

> 	All that said: we're not against making allowances for small support
> 	companies: ask.

It seems people did. Did you made a single serious offer to a RTAI user to
license the patent?

bye, Roman

