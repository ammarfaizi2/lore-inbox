Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSEYRur>; Sat, 25 May 2002 13:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEYRuq>; Sat, 25 May 2002 13:50:46 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:4786 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315167AbSEYRuo>; Sat, 25 May 2002 13:50:44 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)] 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Sat, 25 May 2002 10:22:00 PDT."
             <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com> 
Date: Sat, 25 May 2002 19:50:30 +0200
Message-Id: <20020525175035.3580211972@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com>
you wrote:
> 
> The thing that disgusts me is that this "patent" thing is used as a
> complete red herring, and the real issue is that some people don't like
> the fact that the kernel is under the GPL. Tough cookies.

This is your interpretation, and it is not correct.

> Some people (you and Karim) seem to think that the GPL requirement si
> going to hurt Linux in the embedded space. Fair enough. That's what all

I'm not sure if you really bothered to read what Karim wrote. The GPL
itsef is not the problem, as long as you can draw a line between some
"base  system"  (which  is  strictly  GPL  -  like  RTAI)  and   some
application code.

I do like it very much when all code I write is GPLed, but there  are
situations  where  a there are good reasons for some application code
to remain closed. It seems, this is not a  problem  with  Linux.  But
FSMlabs spreads FUD trying to prevent this for all RT stuff.

What do you think: it it OK (both from the legal and from  the  ethic
point  of  view)  that  somebody  writes  and distributes proprietary
application code?

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Testing can show the presense of bugs, but not their absence.
                                                   -- Edsger Dijkstra
