Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281702AbRKQE7j>; Fri, 16 Nov 2001 23:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281704AbRKQE73>; Fri, 16 Nov 2001 23:59:29 -0500
Received: from alex.intersurf.net ([216.115.129.11]:65286 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S281702AbRKQE70>; Fri, 16 Nov 2001 23:59:26 -0500
Date: Fri, 16 Nov 2001 22:59:24 -0600
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AMD SMP capability sanity checking.
Message-Id: <20011116225924.3390dc77.markorr@intersurf.com>
In-Reply-To: <20011116231141.A3030@faceprint.com>
In-Reply-To: <3BF5952E.E73BB648@resilience.com>
	<Pine.LNX.4.30.0111162353140.32578-100000@Appserv.suse.de>
	<20011116231141.A3030@faceprint.com>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001 23:11:41 -0500
faceprint@faceprint.com (Nathan Walp) wrote:

> Actually, it's probably closer to:
> 
>    make cpu
>       |
>    smp tests run ok? -------> No, sell as XP
>       |
>    yes, do we have more demand
>    for XPs than we have supply
>    of those that didn't pass? -------> Yes, sell as XP
>       |
>    No, sell as MP

Yes, this is much closer to what's happening.  I'd bet that most
Palomino chips would pass the smp tests,  meaning many more MPs than
they'd ever need.    They're probably just putting a bucket in the
manufacturing stream,   testing those, and putting the rejects back
in the stream.

> Remember, AMD is just trying to make a buck.  If they've got a bunch of
> MP CPUs "sitting on the shelves" while no one can get their hands on the
> XPs, some of those MPs are going to "become" XPs.  For those of us on a
> budget, we can only hope to get one of *those* variety of XPs.

Umm...I cant see chips that have already been marked as MPs being
converted to XPs.     Odds are the ratio of XP to MP is probably 10:1
or greater.  

> Now, that said, I'm probably going to buy MPs when I build my machine,
> as long as the price difference stays as the current low levels.
> Consider it a "warranty" or something.

...and considering AMD doesnt lag in bringing out MPs.  Right now
XP 1900s are widely available, but the highest speed MP's are 1800s.

I've heard that the AMD 762 northbridge only works up to 12.5x133
(1666MHz) so they'll hit the wall with the MPs pretty soon unless they
have an updated stepping.

