Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316175AbSEZP6W>; Sun, 26 May 2002 11:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316181AbSEZP6V>; Sun, 26 May 2002 11:58:21 -0400
Received: from white.pocketinet.com ([12.17.167.5]:23052 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S316175AbSEZP6U>; Sun, 26 May 2002 11:58:20 -0400
Message-ID: <009701c204ce$28a325f0$6407070a@blue>
From: "Nicholas Knight" <nknight@pocketinet.com>
To: <yodaiken@fsmlabs.com>, "Roman Zippel" <zippel@linux-m68k.org>
Cc: "David Woodhouse" <dwmw2@infradead.org>, "Larry McVoy" <lm@bitmover.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Linus Torvalds" <torvalds@transmeta.com>,
        "Wolfgang Denk" <wd@denx.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020526072637.A18692@hq.fsmlabs.com> <Pine.LNX.4.21.0205261607470.17583-100000@serv> <20020526082142.C18843@hq.fsmlabs.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sun, 26 May 2002 08:58:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 26 May 2002 15:55:12.0944 (UTC) FILETIME=[B8777B00:01C204CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: <yodaiken@fsmlabs.com>
Sent: Sunday, May 26, 2002 7:21 AM

> On Sun, May 26, 2002 at 04:09:46PM +0200, Roman Zippel wrote:
> > Hi,
> >
> > On Sun, 26 May 2002 yodaiken@fsmlabs.com wrote:
> >
> > > > It's been asserted that the patent licence requires that _all_
userspace
> > > > apps running on the system by GPL'd. Yet there are many Free
Software
> > > > applications in a standard Linux distribution that are under
> > > > GPL-incompatible licences. Apache, xinetd, etc...
> > > >
> > > > If that interpretation is true, it _would_ be a problem, and not
just for
> > > > those trying to make money from it.
> > >
> > > That interpretation is not just false, it is silly.
> >
> > Then why don't you specify in the license what "use of the Patented
> > Process" means?
> >
> > bye, Roman
>
> It means just what it says.

I'm going to stick my nose in here because this is just getting plain
absurd.
Having read the patent license as best I can, I'm going to ask a question
that evidently nobody has felt the need to ask plainly and clearly. Either
that, or nobody has bothered to actually read the patent license.

If I modify the Open RTLinux software that FSMLabs provides, and distribute
the modified version under the GPL, and then use a feature I added through
the modification in a program I'm distributing under a non-GPL license, am I
in violation of the Open RTLinux patent license?

This seems to be what's confusing people. And is a little confusing to me,
but my guess is that the answer is "yes, you are in violation of the patent
license".

The "use it for whatever you want unmodified" terms of the patent license
seem stupidly straightforward, so I can't see how THAT is causing any
confusion.

