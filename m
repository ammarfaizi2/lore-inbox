Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRCHUMI>; Thu, 8 Mar 2001 15:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRCHUL6>; Thu, 8 Mar 2001 15:11:58 -0500
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.42.218.237]:2804 "EHLO
	scotch.homeip.net") by vger.kernel.org with ESMTP
	id <S129569AbRCHULi>; Thu, 8 Mar 2001 15:11:38 -0500
Date: Thu, 8 Mar 2001 15:10:15 -0500 (EST)
From: God <atm@pinky.penguinpowered.com>
To: Ben Greear <greearb@candelatech.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened
 ?(No
In-Reply-To: <3AA7276B.DB9AEC11@candelatech.com>
Message-ID: <Pine.LNX.4.21.0103081456000.878-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Ben Greear wrote:

> Date: Wed, 07 Mar 2001 23:32:11 -0700
> From: Ben Greear <greearb@candelatech.com>
> To: Alexander Viro <viro@math.psu.edu>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
>      Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened
>     ?(No
> 
> Alexander Viro wrote:
> > 
> > On Wed, 7 Mar 2001, Ben Greear wrote:
> > 
> > > However, messing with the hdparms options can do random things, at
> > > least from my perspective as a user:  It may bring exciting new performance
> > > to your system, and it may subtly, or not so, corrupt your file system.
> > 
> > It's root-only. If you run unfamiliar stuff as root without thorough
> > RTFM or choose to ignore "use with extreme caution" contained in the
> > manpage - hdparm is the least of your problems. Think of it as evolution
> > in action...
> >                                                         Cheers,
> >                                                                 Al
> 
> I see it differently:  If it's possible for the driver to protect the
> user, and it does not, 

Agreed.

> then it strikes me as irresponsible programming.

Also agreed.

> If there is a reason other than 'only elite users are cool enough to tune
> their system, and they never make mistakes', 

Agreed

> then that's ok,

NOT Agreed.  

> but I have not heard that argument yet.
> 

What must be understood by the linux community is that if it continues to
target the user base of other Desktop OS's, (ok the only other one... we
all know which),  Then it MUST be userfriendly.  

How friendly?  Think about the AOL and newuser jokes we have all heard at
one point or another.  The truth is, _assuming_ the user will know, or
know better, is the WRONG way to go.  

Look at some of the confirmation requests in windows, some ask you twice
if you whish to perform an action.  Even Red Hat (that I know of, others
may as well), has an alias for "rm" that by
default turns on confirmation.  Why?  Because not ALL users will know
better.  Sure there are warnings that you can put in a man page somewhere,
but the truth is few users are actually going to READ the page.  Is it
there fault?  Yes.  But should it be so easy to lose their data over
it rather then writting code to detect if said feature will work or
not? ...  

If the majority of people on this list think YES, then Linux
truely has a long way to go ......

> 
> Either way, I've said my piece, and will go back to wrestling with
> why my network/overall performance is sucking so badly all of a sudden...
> 
> Enjoy,
> Ben
> 
> 



