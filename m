Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289711AbSA2Pfp>; Tue, 29 Jan 2002 10:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289715AbSA2Pfg>; Tue, 29 Jan 2002 10:35:36 -0500
Received: from zeke.inet.com ([199.171.211.198]:42459 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S289711AbSA2PfY>;
	Tue, 29 Jan 2002 10:35:24 -0500
Message-ID: <3C56C12E.CB73B70E@inet.com>
Date: Tue, 29 Jan 2002 09:35:10 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291733500.11959-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 29 Jan 2002, Dave Jones wrote:
> 
> >  > out of the 300+ email addresses in the MAINTAINERS file, 15 addresses
> >  > bounced physically. (whether they bounce logically is another question.)
> >
> >  Care to remove the bogus ones from MAINTAINERS
> 
> yeah, was in the process of doing that. Patch against 2.5.3-pre6 attached.
> Altogether 13 addresses are affected. I have only removed the
> hard-bouncing email addresses, names and list names remain (of course).
> 
>         Ingo

Humble suggestion:  Add a date field for "took over maintainence
on/before: yyyy-mm-dd" and a field for "last verified: yyyy-mm-dd" so we
know when we last checked on the existance/etc. of a maintainer.  (And
maybe an "AWAL on/before: yyyy-mm-dd" for those without known working
addresses.)

Thoughts?

Ah, I see Russell King made a similar suggestion...

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
