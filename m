Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSA3Bcy>; Tue, 29 Jan 2002 20:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSA3Bco>; Tue, 29 Jan 2002 20:32:44 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:1541 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S287858AbSA3Bca>;
	Tue, 29 Jan 2002 20:32:30 -0500
Message-Id: <5.1.0.14.0.20020130122650.023213c0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 30 Jan 2002 12:32:25 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: A modest proposal -- We need a patch penguin
Cc: Jeff Garzik <garzik@havoc.gtf.org>,
        Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        John Weber <weber@nyc.rr.com>
In-Reply-To: <20020129201806.B12201@havoc.gtf.org>
In-Reply-To: <5.1.0.14.0.20020130113958.00a04390@mail.amc.localnet>
 <3C5600A6.3080605@nyc.rr.com>
 <87n0yxqa6e.fsf@tigram.bogus.local>
 <5.1.0.14.0.20020130113958.00a04390@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:18 PM 29/01/02 -0500, Jeff Garzik wrote:
>On Wed, Jan 30, 2002 at 12:00:11PM +1100, Stuart Young wrote:
> > Perhaps it's time we set up a specific lkml-patch mailing list, and leave
>
>I like the suggestion (most recently, of Daniel?  pardon if I
>miscredit) of having patches-2.[45]@vger.kernel.org type addresses,
>which would archive patches, and have a high noise-to-signal ratio.
>Maybe even filter out all non-patches.
>
>The big issue I cannot decide upon is whether standard e-mails should be
>         To: torvalds@
>         CC: patches-2.4@
>or just
>         To: patches-2.4@
>
>(I'm guessing Linus would prefer the first, but who knows)

Perhaps it'd be easier for patches-2.4 to actually send a copy to whoever 
is the relevant maintainer of a "section" (which could be worked out from 
the path in the patch, as long as it's made relevant to linux/) as well as 
the 2.4 maintainer? There is a lot of things that can be done here.

>Also, something noone has mentioned is out-of-band patches.  Security 
>fixes and other patches which for various reasons go straight to Linus.

Perhaps that is a good use for my lkml-patches idea, which gives those who 
have no avenue a place to post patches so they get picked up.

Something that does need to be done is that various directories under the 
kernel tree need to have someone "who receives patches" for that part, and 
who forwards them onto the kernel maintainer (eg: Linus, Marcello, etc) for 
further review/inclusion/rejection. This way, anything that doesn't fall 
under a particular maintainer gets sectioned off to someone, so it does get 
review, and hopefully a reply.


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

