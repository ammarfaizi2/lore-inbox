Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278840AbRJVOpt>; Mon, 22 Oct 2001 10:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278842AbRJVOpk>; Mon, 22 Oct 2001 10:45:40 -0400
Received: from web13103.mail.yahoo.com ([216.136.174.148]:41857 "HELO
	web13103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278840AbRJVOp1>; Mon, 22 Oct 2001 10:45:27 -0400
Message-ID: <20011022144601.55173.qmail@web13103.mail.yahoo.com>
Date: Mon, 22 Oct 2001 07:46:01 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: [PATCH] updated preempt-kernel
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1003562833.862.65.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Robert Love <rml@tech9.net> wrote:
> Testers Wanted:
> 
> patches to enable a fully preemptible kernel are
> available at:
> 	http://tech9.net/rml/linux
> for kernels 2.4.10, 2.4.12, 2.4.12-ac3, and
> 2.4.13-pre5.
> 
> What is this:
> 
> A preemptible kernel.  It lowers your latency.
> 

Hi 
I'm using the preemptible kernel patch since 2.4.10 
(no 2.4.11). And it makes a big difference on 486 with
12Megs of ram. 
I can't send you benchmarks (i don't have time for
this but if you really want one ... it can be arranged
:-)). 
But:

When I run a configure script I can actually see it
running (without this patch it is very slow).

The coolest thing was that I could run Gnome and KDE
(with loadavg of 4 and waiting 2 to 4 minutes for an
application to start (because of ram I think))
something not possible without the preemtible kernel.
I don't swear after them anyway.( I prefer fvwm)

Compilation is much faster (i'll make a benchmark
compiling linux kernel -- i promise :-)) ).

The system is stable with high system loads.
Now is kernel 2.4.12 and no problems at all.

Any chance to be in the main stable kernel ?

Bye 



__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
