Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160779-27300>; Mon, 1 Feb 1999 05:04:25 -0500
Received: by vger.rutgers.edu id <160742-27302>; Mon, 1 Feb 1999 05:04:05 -0500
Received: from parasite.irisa.fr ([131.254.12.47]:48381 "EHLO parasite.irisa.fr" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160763-27302>; Mon, 1 Feb 1999 05:03:50 -0500
To: Richard Gooch <rgooch@atnf.csiro.au>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH] [NEW] msr v1 available
References: <199901220720.SAA06460@vindaloo.atnf.CSIRO.AU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "David Mentr'e" <David.Mentre@irisa.fr>
Date: 01 Feb 1999 11:16:17 +0100
In-Reply-To: Richard Gooch's message of "Fri, 22 Jan 1999 18:20:04 +1100"
Message-ID: <wd87lu2whse.fsf@parate.irisa.fr>
User-Agent: Gnus/5.070072 (Pterodactyl Gnus v0.72) Emacs/20.3
Sender: owner-linux-kernel@vger.rutgers.edu

 Hi Richard,

Richard Gooch <rgooch@atnf.csiro.au> writes:

> It is my hope that the device driver interfaces are sufficiently
> generic that they will be appropriate for other CPU architectures. I'd
> welcome feedback from the non-x86 hackers out there.

I'm far from a hacker but regarding API, you should check that your
interface could support the PerfAPI effort. This API is aiming at
providing the same *programmer* interface on many OS. 

 PerfAPI - Performance Data Standard and API
  http://icl.cs.utk.edu/projects/papi/

Another question: does your patch support SMP systems ?

I'll try to put a link on my web page
(http://www.irisa.fr/prive/dmentre/linux-counters/). 

Hope it helps,
david
-- 
 David.Mentre@irisa.fr -- http://www.irisa.fr/prive/dmentre/
 Opinions expressed here are only mine.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
