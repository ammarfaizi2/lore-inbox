Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275014AbRIYOTW>; Tue, 25 Sep 2001 10:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275017AbRIYOTM>; Tue, 25 Sep 2001 10:19:12 -0400
Received: from lfmobile.lmc.cs.sunysb.edu ([130.245.211.22]:56454 "EHLO
	lfmobile.lmc.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id <S275014AbRIYOTC>; Tue, 25 Sep 2001 10:19:02 -0400
To: Juri Haberland <haberland@altus.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 power management lockup
In-Reply-To: <20010924220433.29ED8763@localhost.blazeconnect.net>
	<3BB03A41.4B64F831@altus.de>
From: Luis Fernando Pias de Castro <luis@cs.sunysb.edu>
In-Reply-To: <3BB03A41.4B64F831@altus.de>
Date: 25 Sep 2001 10:15:17 -0400
Message-ID: <87g09bicga.fsf@lfmobile.lmc.cs.sunysb.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably not much interesting, but I have an i8000 working fine
(suspending when display is closed and all) with 2.4.8-ac11 (and
several others prior to this) as long as I never load the agpgart
module.

-Luis


Juri Haberland <haberland@altus.de> writes:

> Jason Straight wrote:
> > 
> > I've got a Dell Inspiron 8000 laptop, I had problems with 2.4.9 and .8 with
> > AC patches where my system would turn itself off at seemingly random
> > intervals, and closing my display would freeze the machine.
> > 
> > Well, 2.4.9 clean was fine as was 2.4.8, but now 2.4.10 is doing it again, I
> > upgraded my BIOS to the newest avail just in case with no change. 2.4.10
> > doesn't seem to power off, but it will freeze on display close and will power
> > off if the display is left closed for a while. All power management in my
> > BIOS is off as it has been forever.j
> > 
> > I mentioned this on the list a while back with 2.4.8-ac-something
> 
> And I think I posted a me-too on this and I now have the same problem
> with my I8000...
> 
> Juri
> 
> -- 
>   If each of us have one object, and we exchange them,
>      then each of us still has one object.
>   If each of us have one idea,   and we exchange them,
>      then each of us now has two ideas.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
