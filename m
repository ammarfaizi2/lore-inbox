Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbRL3EYy>; Sat, 29 Dec 2001 23:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287336AbRL3EYp>; Sat, 29 Dec 2001 23:24:45 -0500
Received: from ns.suse.de ([213.95.15.193]:37131 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287333AbRL3EYa>;
	Sat, 29 Dec 2001 23:24:30 -0500
Date: Sun, 30 Dec 2001 05:24:29 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: State of the new config & build system
In-Reply-To: <20011230043458.E2434@bart>
Message-ID: <Pine.LNX.4.33.0112300507420.3122-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Viktor Rosenfeld wrote:

> > Kernel building is not for newbies.
> Crap.  Back in 1995, I had to compile a kernel to get Linux installed,
> because the packaged kernel did not include support for ATAPI CD-ROM
> drives.  I had no Unix experience whatsoever, basically what you call a
> newbie.

Things have changed dramatically since 1995.
In particular, distros got a lot friendlier to install, and customise.
If theres a valid reason for Aunt Tillie to rebuild her kernel, it means
her distro of choice is doing something wrong.

> - people/cooperations without Linux kernel compilation experience, who
>   might need a feature that's only available in a development kernel,
> - *newbies*, that are generally interested in learning Linux in all its
>   ways.
> Your attitude strikes me as unnessicarily elitist.

Dumbing down the learning curve doesn't necessary make things easier
for people to learn. Reluctance to read documentation for eg is something
that will plague us no matter how simple we make it to build kernels.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

