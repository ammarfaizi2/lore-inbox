Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSE2R3l>; Wed, 29 May 2002 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSE2R3k>; Wed, 29 May 2002 13:29:40 -0400
Received: from white.pocketinet.com ([12.17.167.5]:60714 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S314085AbSE2R3i>; Wed, 29 May 2002 13:29:38 -0400
Message-ID: <00a501c20736$6a3e6e60$6407070a@blue>
From: "Nicholas Knight" <nknight@pocketinet.com>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        "Jonathan Corbet" <corbet-lk@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1022678126.9255.182.camel@irongate.swansea.linux.org.uk> <20020529141300.30309.qmail@eklektix.com> <20020529171524.A5554@kushida.apsleyroad.org>
Subject: Re: business models [was patent stuff]
Date: Wed, 29 May 2002 10:29:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 May 2002 17:26:28.0257 (UTC) FILETIME=[F73F3110:01C20735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
To: "Jonathan Corbet" <corbet-lk@lwn.net>
Cc: <linux-kernel@vger.kernel.org>; "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Wednesday, May 29, 2002 9:15 AM
Subject: Re: business models [was patent stuff]


> Jonathan Corbet wrote:
> > Alan said:
> > > I would worry much more about the million odd patents IBM have, where
> > > IBM have no general statement of this nature than the Red Hat ones.
> > > Perhaps once the Red Hat statement is published IBM can be persuaded
to
> > > show willing ?
> >
> > For what it's worth, the Red Hat statement is at:
> >
> > http://www.redhat.com/legal/patent_policy.html
> >
> > No patent enforcement against you if you're using a Red Hat-approved
open
> > source license - their list does not include BSD.
>
> The Red Hat-approved licences don't include LGPL either.
>
> Red Hat's definition of "Open Source/Free Software" ("means any software
> which is licensed under an Approved License.") could do with some
> clarification.
>

The definition of "defensive patent" could do with some reassesment.

The only way I can see a software patent as truely defensive, is if it's
explicitly
licensed for use by anyone, anywhere, for anything, under any software
license.
The only thing it should be used to defend against is someone else patenting
it
and denying Red Hat the right to use it, it shouldn't be used to prevent
others,
no matter who they are, from using it.

If there's a proper name for what Red Hat now has, it's "Free Software
Foundation Compliant" and "Linux Specific". This isn't a defensive patent,
it's
a patent filed for the express purpose of preventing systems besides Linux
from taking advantage of the techniques covered by the patent.

Off the top of my head, I can think of only one at least somewhat-known OS
licensed under any of their "approved" licenses, and that's AtheOS (GPL).
Relatively few people use AtheOS yet, and I doubt that will change soon.

On the other hand, at the very front of my mind at all times are the names
of
three fairly well-known systems that are in fairly wide-spread use and are
decidedly open source:
FreeBSD (significant widespread use)
NetBSD
OpenBSD

I don't care what anybody's personal opinion of these systems is, they are
Free and Open Souce in every sense of the terms, and a lot of people use
them. There's just one problem, they're frequently in direct competition
with Linux. And since Red Hat is decidedly the front-man of the U.S.
Linux distribution market, they are directly in competition with Red Hat.
Rather convenient that they can't make use of the patent, isn't it?

Of course, if Red Hat went to the logical conclusion of opening the patent
for use, Microsoft would end up able to use the patent, and I doubt anyone
but Microsoft would really want that. Hence this solution:

Explicitly license the patent to anyone and everyone, EXCEPT Microsoft.

Why do I not have a problem with not allowing Microsoft to use it?
Simple, they've been caught, in very recent history, using very illiegal
business practices. They shouldn't have the right to use their *own*
patents.


Of course, this still leaves it open to other competitors, and we can't have
that, now can we?


> I wonder what their stance is if I dual license under BSD and GPL.  Do I

You certainly could, but I doubt there would be any point. The software
has to be under the terms of the GPLv2, IBM PL v1, CPL v0.5, QPLv1,
or any of Red Hat's Open Source licenses in order for the  patented
method to be used.

> have to be explicit about it?  Or is that too loose - must it be GPL only?
>
> I wonder if that means I have to explicitly list my high performance web
> server, which takes advantage of the patented directory lookup of
> course, as dual licensed under GPL and LGPL, or if that is taken as
> implied.

I could see splitting components up, some under GPL, some under LGPL.
But then you have the issue you're already familier with with FSMLabs'
patent, calls to the GPL'd code may have to be made by GPL'd code only.

>
> etc.
>
> -- Jamie


