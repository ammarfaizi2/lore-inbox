Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129925AbQLBRLW>; Sat, 2 Dec 2000 12:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129889AbQLBRLM>; Sat, 2 Dec 2000 12:11:12 -0500
Received: from mailout1-0.nyroc.rr.com ([24.92.226.81]:42925 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129516AbQLBRK7>; Sat, 2 Dec 2000 12:10:59 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Gnea" <gnea@rochester.rr.com>
To: Buddha Buck <bmbuck@14850.com>, linux-kernel@vger.kernel.org
Subject: Re: HOW-DO-I: Diagnosing hardware problems
X-Mailer: Pronto v2.2.2
Date: 02 Dec 2000 11:34:15 EST
Reply-To: "Gnea" <gnea@rochester.rr.com>
In-Reply-To: <5.0.0.25.0.20001130095146.00c3aae0@armstrong.cse.buffalo.edu>
In-Reply-To: <5.0.0.25.0.20001130095146.00c3aae0@armstrong.cse.buffalo.edu>
Message-ID: <20001202162932.AAA12198@mail2.nyroc.rr.com@celery>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Nov 2000 10:12:34 -0500, Buddha Buck blurted forth:

> Hi,
[snip]
>  When this first started (under 2.4.0pre10), I was getting oopses, showing 
>  the system was dying in wake_up, while trying to schedule during an 
>  interrupt (I think that's what the oops said).  Some oopses would be 
>  logged, and not kill the system, others would kill the system, and not be 
>  logged.  When I downgraded to 2.2.17+ide, I stopped getting oopses, and the 
>  lockups stopped, for a while.  Now the system (under both 2.2.18 and 
>  2.4.0pre11) lockups but doesn't oops, not even to the console.
[snip]

sounds like a bad CPU fan, take the cover off of the computer and start
it up, observe how fast the fan on the CPU is running. if it's not
running at all, that's your problem. turn the computer off and do not
start it again until you've replaced it, you can seriously burn stuff
out if it continues to run like that.  also, is there a lot of clutter
in the case? wires everywhere? u may want to consider getting some
twist-ties or rubber bands or whatever and using them to clean up the
mess to allow proper ventilation of the system and get heat out of
there... this sounds like the most logical problem/solution to me, but
of course i could be wrong.. give this a go and see what happens.

-- 
	.oO gnea at rochester dot rr dot com Oo.
	    .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish" -unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
