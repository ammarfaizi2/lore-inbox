Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbREPJWS>; Wed, 16 May 2001 05:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261848AbREPJWI>; Wed, 16 May 2001 05:22:08 -0400
Received: from hermes.sistina.com ([208.210.145.141]:43526 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S261847AbREPJVy>;
	Wed, 16 May 2001 05:21:54 -0400
Date: Wed, 16 May 2001 11:19:03 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@sistina.com>
To: linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM 1.0 release decision
Message-ID: <20010516111903.E11984@sistina.com>
Reply-To: Mauelshagen@sistina.com
In-Reply-To: <3AFC42EB.2910DAAE@wrkhors.com> <Pine.LNX.4.21.0105132046150.5468-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0105132046150.5468-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sun, May 13, 2001 at 08:48:19PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 08:48:19PM -0300, Rik van Riel wrote:
> On Fri, 11 May 2001, Steven Lembark wrote:
> 
> > for my part running the system i'd rather have the "production"
> > LVM and kernel releases in sync and not have to worry about it.
> > if i need a beta/inter-version release then i'll deal with the
> > extra issues.
> 
> Agreed.  If the in-kernel LVM cannot be trusted, I really
> don't see why Sistina would ever want to associate its name
> with something broken?

Rik, that's not an issue at all and sorry, it doesn't help either!

With the help of community contributors we *do* provide the most recent
code with as few bugs as possible at www.sistina.com/lvm as we always did.

Everybody could and can get it from there and established LVM users continue
to do it this way.

OTOH we need a lot of time now to get smaller patches into vanilla.

Therefore we kindly asked for community oppinions to help the situation.


Unless a bigger LVM patch to vanilla is accepted, we need to spend a lot of work
on providing those smaller chunks of patches which distracts us a lot from
other work.

Don't tell me that this is all our fault; 
this wouldn't *help* to fasten the process either!

A little trust to accept a bigger patch *and* to sort pending issues
out with the help of the community afterwards is a valid approach IMO to
get faster to the point of an updated vanilla LVM driver than with the
tiny patches approach.

Linus, Alan et al.: maybe you could think about it again and
                    accept one larger LVM patch. Thanks.

> 
> I think it would be better for everyone (users, Sistina's
> corporate image and Linux) to get something stable into the
> kernel before sending out the press release ;)
> 
> (after all, a version number change is just a one-liner patch
> away ;))
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 
> _______________________________________________
> linux-lvm mailing list
> linux-lvm@sistina.com
> http://lists.sistina.com/mailman/listinfo/linux-lvm

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
