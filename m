Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRCSMvV>; Mon, 19 Mar 2001 07:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRCSMvM>; Mon, 19 Mar 2001 07:51:12 -0500
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:34433 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S131396AbRCSMuz>; Mon, 19 Mar 2001 07:50:55 -0500
Date: Mon, 19 Mar 2001 13:49:44 +0100
From: Ookhoi <ookhoi@dds.nl>
To: Daniel Quinlan <quinlan@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: is it possible to upgrade crusoe code morphing software with linux?
Message-ID: <20010319134944.O937@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010210224855.D7877@bug.ucw.cz> <Pine.LNX.4.10.10102130928490.29787-100000@penguin.transmeta.com> <6y66idbiai.fsf@magnesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <6y66idbiai.fsf@magnesium.transmeta.com>; from quinlan@transmeta.com on Wed, Feb 14, 2001 at 03:44:37AM -0800
X-Uptime: 4:05pm  up  2:01,  5 users,  load average: 1.52, 1.66, 1.64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

This is a message from 14 Feb.

> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > We're going through our docs and we have internal programs that we'll
> > release for this so that you'll not just have docs but actually working
> > code too. It just needs to be cleaned up a bit, and go through the proper
> > channels (ever wonder why open source gets deveoped faster?). It really
> > should be "any day now".
> 
> Working code is better anyway (and in this case, it's first).  Go to
> your favorite kernel.org mirror and check out
> 
>   /pub/linux/utils/cpu/crusoe/longrun-0.9.tar.gz
> 
> It does everything you could ever want and more, as long as you include
> the CPUID and MSR devices in your kernel, set up the devices correctly,
> etc.

longrun works great, thank you. :-)
But I read this:

http://news.cnet.com/news/0-1006-200-3665351.html

   Transmeta, Intel in a battle for notebooks By Michael Kanellos
   Staff Writer, CNET News.com
   November 13, 2000, 2:25 p.m. PT

   comdex LAS VEGAS--Transmeta and Intel will slug it out next year with
   a slew of low-powered chips for notebooks. 

   Comdex 2000: Back to the future In the first quarter of next year,  
   Transmeta announced Monday, it will release version 4.2 of its
   code-morphing software that significantly reduces processor power
   consumption. Code-morphing software is a software layer on top of a
   chip that picks up a number of the duties that would normally be   
   handled by the chip itself and thereby cuts power consumption.  

   "We made a substantial difference (in power consumption) in
   essentially what is the same silicon," Dave Ditzel, Transmeta CEO,
   said Monday in an interview with CNET News.com at the Comdex trade
   show here.

Now I searched www.transmeta.com and can't find a thing about where to
get the upgrade or the tools to perform the upgrade. Are they available
somewhere or is there an eta?

dmesg:
CPU: Processor revision 1.3.1.2, 600 MHz
CPU: Code Morphing Software revision 4.1.4-7-51
CPU: 20000805 23:30 official release 4.1.4#2
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03

I would love to upgrade to version 4.2 :-)

Thanks!

	Ookhoi
