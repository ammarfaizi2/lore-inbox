Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281332AbRKEU5C>; Mon, 5 Nov 2001 15:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281335AbRKEU4w>; Mon, 5 Nov 2001 15:56:52 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:27577 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281332AbRKEU4j> convert rfc822-to-8bit; Mon, 5 Nov 2001 15:56:39 -0500
Date: Mon, 5 Nov 2001 19:11:29 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Ben Greear <greearb@candelatech.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, John Fremlin <john@fremlin.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <3BE6EF7D.40103@candelatech.com>
Message-ID: <20011105190050.W1870-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Ben Greear wrote:

> Gérard Roudier wrote:
>
> >
> > On Sun, 4 Nov 2001, Manfred Spraul wrote:
> >
> >
> >>Jeff Garzik wrote:
> >>
> >>>Gérard Roudier wrote:
> >>>
> >>>>different from Tekram adapters. Btw, my Netgear FA311 board is not handled
> >>>>by the sis driver of linux-2.2.20 and my little finger tells me that it
> >>>>could be so given a few code addition.
> >>>>
> >>>Unless you have a really strange board I haven't seen, NetGear FA311 are
> >>>the natsemi DP83815/6 chips, handling by either "natsemi" or "fa311"
> >>>drivers, not "sis900" driver...
> >>>
> >>>
> >>sis900 and natsemi are similar, probably both could be handled with one
> >>driver.
> >>e.g. freebsd has one driver for natsemi and sis900.
> >>
> >>But I'm not a big fan of huge drivers that handle multiple 99%
> >>compatible controllers and always break for one controller if you try to
> >>fix another controller, so I won't try to merge them.
> >>
> >
> > So you would have preferred, for example, to have dozens of different
> > drivers for SYM53C8XX chips and probably as many for Adaptec aic7xxx ones.
> > And, probably, one set of different drivers per O/S. And why not one set
> > per O/S major version and even per adjacent ones of the same O/S.
> >
> > Given all the different brands that use similar or compatibles chips, the
> > way you want drivers to be developped and maintained looks just
> > unrealistic to me.
>
>
> Jeff has intimate knowledge of the Tulip driver, one of the more complex
> drivers that supports a bazillion different cards.  And also one of the hardest
> to get (and keep) working on all of the devices it seems....
>
> I think he has a very valid point....

Ok. I do understand the point, now.
Sorry for the misunderstanding. I caught the remark as a too general
statement.

May thanks for the efforts maintaining tulip drivers.

Regards,
  Gérard.

