Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289987AbSAWTlE>; Wed, 23 Jan 2002 14:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSAWTkz>; Wed, 23 Jan 2002 14:40:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:40978 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289987AbSAWTkg>; Wed, 23 Jan 2002 14:40:36 -0500
Message-ID: <3C4F100C.5F817D73@zip.com.au>
Date: Wed, 23 Jan 2002 11:33:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Antti Salmela <asalmela@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.17, SMP, AMD, devfs, highmem.
In-Reply-To: <20020123152406.A4992@wasala.fi>,
		<20020123152406.A4992@wasala.fi> <200201231749.g0NHn1h31634@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Antti Salmela writes:
> > Kernel compiled with gcc version 2.95.4 (Debian prerelease).
> >
> > If any additional information is required, please ask.
> 
> If you had searched the list archives, you would have seen that this
> bug has already been fixed. Even if you're too lazy to do that, you
> should at least apply the latest pre-patch (2.4.18-pre6 as I write
> this) and see if the problem goes away. That's standard procedure:
> always try to reproduce an Oops using the latest kernel. 2.4.17 is
> over a month old: a lot has happened since then.
> 

Richard,  that's just completely over the top.  Antti is quite
justified in reporting a problem against the stable kernel,
particularly when it has a version number as late as 2.4.17.

We want *more* bug reports, not less.  And if some of them
are dupes, then we should just roll with it and be polite.
It's not reasonable to send everyone away to trawl the archives,
read the prerelease changelogs, etc.  That's just shooting
ourselves in the feet.

-
