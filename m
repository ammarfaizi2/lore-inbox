Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318105AbSG2Vyw>; Mon, 29 Jul 2002 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSG2Vyw>; Mon, 29 Jul 2002 17:54:52 -0400
Received: from mail.networldchina.com ([65.88.251.103]:5715 "EHLO networld.com")
	by vger.kernel.org with ESMTP id <S318105AbSG2Vyv>;
	Mon, 29 Jul 2002 17:54:51 -0400
Message-ID: <3D45BB72.70257D74@networld.com>
Date: Mon, 29 Jul 2002 16:02:26 -0600
From: Ray Friess <rayfri@networld.com>
X-Mailer: Mozilla 4.76 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Rodland <arodland@noln.com>, "David D. Hagood" <wowbagger@sktc.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
References: <20020727000005.54da5431.arodland@noln.com> <200207270526.g6R5Qw942780@saturn.cs.uml.edu> <20020727015703.21f47a37.arodland@noln.com> <3D4298C6.9080103@sktc.net> <20020727114509.0a1eee2a.arodland@noln.com> <20020729174734.B38@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

will someone turn off the damn server or something...  I've gotten this same
message 40 times already....



Pavel Machek wrote:

> Hi!
>
> > > I don't understand the direction this discussion is taking.
> > >
> > > Either you are trying to output the panic information with minimal
> > > hardware, and in a form a human might be able to decode, in which case
> > > the Morse option seems to me to be the best, or you are trying to
> > > panic in a machine readable format - in which case just dump the data
> > > out /dev/ttyS0 and be done with it!
> > >
> > > To my way of thinking, the idea of the Morse option is that if an oops
> > >
> > > happens when you are not expecting it, and you haven't set up any
> > > equipment to help you, you still have a shot at getting the data.
> >
> >
> > To my way of thinking, this is still 'minimal' -- it's just a different
> > minimum.
> >
> > It's the 'minimum' way to get the panic message out digitally, in such
> > a way that I might be able to recover it using a tape recorder or a
> > telephone. Actually, morse is probably that, but morse loses data and
> > doesn't have any redundancy.
>
> You don't need redundancy. You should just repeat message over and over
> and over and over and....
>
> If you don't want morse to loose data, invent new codes for different
> parenthesis etc.
>                                                                 Pavel
> --
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

