Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSE0CoE>; Sun, 26 May 2002 22:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316498AbSE0CoD>; Sun, 26 May 2002 22:44:03 -0400
Received: from dsl-213-023-038-154.arcor-ip.net ([213.23.38.154]:53984 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316496AbSE0CoC>;
	Sun, 26 May 2002 22:44:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Mon, 27 May 2002 04:42:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020526072637.A18692@hq.fsmlabs.com> <Pine.LNX.4.21.0205261607470.17583-100000@serv> <20020526082142.C18843@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17CATB-000473-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 May 2002 16:21, yodaiken@fsmlabs.com wrote:
> On Sun, May 26, 2002 at 04:09:46PM +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Sun, 26 May 2002 yodaiken@fsmlabs.com wrote:
> > 
> > > > It's been asserted that the patent licence requires that _all_ 
userspace 
> > > > apps running on the system by GPL'd. Yet there are many Free Software 
> > > > applications in a standard Linux distribution that are under 
> > > > GPL-incompatible licences. Apache, xinetd, etc...
> > > > 
> > > > If that interpretation is true, it _would_ be a problem, and not just 
for 
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

>From your August 12, 2000 linuxdevices interview:

   RL: OK, so let's talk about the "infamous" RTLinux patent. What's up with 
   that patent?

   ...

   RL: Could that potentially be used to block RTAI from being LGPL?

   Yodaiken: RTLinux is released under the GPL. I have an agreement with 
   Linus that nobody who uses RTLinux with Linux will have to pay royalties.

My question: do you stand by this, at least?  If so, will you put that in 
writing for the rest of us?  Did you really mean what you said, or did you 
add conditions later, such as 'only unmodified RTLinux blessed by me'?  If 
not, then I should be able to backport most RTAI features to RTLinux and call 
the result RTLinux.  Would that be consistent with your agreement with Linus?

-- 
Daniel
