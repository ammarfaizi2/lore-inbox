Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSDUAEc>; Sat, 20 Apr 2002 20:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313302AbSDUAEb>; Sat, 20 Apr 2002 20:04:31 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:32518 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313300AbSDUAEb>; Sat, 20 Apr 2002 20:04:31 -0400
Message-ID: <3CC201F7.B3AC3FDF@linux-m68k.org>
Date: Sun, 21 Apr 2002 02:04:07 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <garzik@havoc.gtf.org>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16ya3u-0000RG-00@starship> <20020420115233.A617@havoc.gtf.org> <3CC19470.ACE2EFA1@linux-m68k.org> <20020420122541.B2093@havoc.gtf.org> <3CC1A31B.AC03136D@linux-m68k.org> <20020420170348.A14186@havoc.gtf.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff Garzik wrote:

> What was Daniel's action?  Remove the text.  Nothing else.  Sure, he
> suggested other options, but he did attempt to implement them?  No.
> He just implied that people need to step up and do this work for him.

He made his intention very clear, you are interpreting something in his
action, that simply isn't there.

> Daniel attempted to remove speech he disgreed with from wide
> distribution -- on distro CDs, kernel.org mirrors, etc.  I am hoping
> it is plainly obvious that removing a doc from one of the mostly
> widely distributed open source projects reduces the doc's distribution
> dramatically.  _That_ is a form of censorship, just like buying out
> printing presses, to silence them, in the old days.  It's still
> around... just progressively harder to obtain.

Censorship requires the means to enforce it and has Daniel this ability?
Could we please stop these "censorship" and "ideology" arguments? In
this context they are simply nonsense.

> And the answer is, it is BK documentation written for kernel developers
> by kernel developers, with the intention of being a SubmittingPatches
> document for BK users.  Very relevant to kernel devel.  This relevance
> was proved by its origin -- emails bouncing back and forth, generally
> originating by Linus, CC'ing me, asking me for the emails I had
> already sent to other hackers, describing kernel development under BK.

kernel development with bk requires net access and so it's sufficient,
when it's available over the net. On the other hand SubmittingPatches
describes the lowest common denominator, which works with any SCM and
doesn't favour any of them.
Personally I don't care what tools people use, but I'm getting
concerned, when a nonfree tool is advertised as tool of choice for
kernel for development as if there would be no choice. bk has advantages
for distributed development, but beside of this they are alternatives
and we should rather encourage users to try them and to help with the
development of them. But there isn't anything like that, so Joe Hacker
has to think he should use bk as SCM to get his patch into the kernel,
because Linus is using it.

bye, Roman
