Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSEYSry>; Sat, 25 May 2002 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315238AbSEYSrx>; Sat, 25 May 2002 14:47:53 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:7946 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S315235AbSEYSrv>; Sat, 25 May 2002 14:47:51 -0400
Message-ID: <3CEFDBE4.5BE20C7C@opersys.com>
Date: Sat, 25 May 2002 14:45:56 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com> <3CEFD65A.ED871095@opersys.com> <20020525143358.A4481@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Mielke wrote:
> None of which proves that it is the right way to do things.

So, this is all about the "right way"? So the right way is to have
everything in the kernel without memory protection?

> >From what I understand, Linux _is_ being considered for RT applications
> by quite a few heavy-weights in the field including IBM, Intel and
> quite a few others. The patent issue that you present does not seem to be
> discouraging them in any way.

True, but see who you're pointing to: Intel and IBM. Both patent heavywheights.
Do you really think they're going to run scared because of one tiny company
with a questionnable patent? I personnally don't. They probably even have
patents which invalidate the rtlinux patent.

Those who do run scared are all those who develop embedded apps and don't
have the size of IBM or Intel to carry them. And there a great deal of those.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
