Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290783AbSAaAuR>; Wed, 30 Jan 2002 19:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290784AbSAaAuL>; Wed, 30 Jan 2002 19:50:11 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:11269 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S290783AbSAaAt4>;
	Wed, 30 Jan 2002 19:49:56 -0500
Message-Id: <5.1.0.14.0.20020131114402.02653b10@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 31 Jan 2002 11:49:50 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Wanted: Volunteer to code a Patchbot
Cc: Roman Zippel <zippel@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rasmus Andersen <rasmus@jaquet.dk>, killeri@iki.fi
In-Reply-To: <E16Vww1-0000FS-00@starship.berlin>
In-Reply-To: <20020130162851.H9765@jaquet.dk>
 <Pine.LNX.4.33.0201301306190.7674-100000@serv>
 <20020130161105.E9765@jaquet.dk>
 <20020130162851.H9765@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:46 PM 30/01/02 +0100, Daniel Phillips wrote:
>On January 30, 2002 04:28 pm, Rasmus Andersen wrote:
> > Somehow, I totally forgot the security disclaimer for some of
> > the points. Obviously, mindlessly patching a makefile and
> > executing it would be a Bad Idea. If no satisfying solution
> > to this can be found, this (execute/compile) step could be
> > foregone.
> >
> > Thanks to Tommy Faasen for raising this point.
>
>I'd say, don't try to run it, just see if it applies cleanly.
>
>Speaking of security, we can't expect Matti to take care of blocking spam
>on the patch lists the way he does on lkml, so that is going to have to
>be handled, or the system will fall apart.  Well, spammers are not going
>to be bright enough to send correctly formed patches that apply without
>rejects I hope, so maybe that is a non-problem.

Possibly, but then it'll reply to the spammer and you'll get bounces left 
and right. Perhaps it's a simple case that the patcher submitting will have 
to have registered the email address before submitting their patch. Only 
needs to be done once (not every time a patch is submitted, that's mad!), 
and weeds out the noise.


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

