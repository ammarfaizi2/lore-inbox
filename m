Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316656AbSE0PT0>; Mon, 27 May 2002 11:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSE0PTZ>; Mon, 27 May 2002 11:19:25 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:14261 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316656AbSE0PTX>; Mon, 27 May 2002 11:19:23 -0400
To: Paratimer@aol.com
Cc: rddunlap@osdl.org, lm@bitmover.com, erwin@muffin.org, yodaiken@fsmlabs.com,
        linux-kernel@vger.kernel.org, rtai@rtai.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: RTAI/RtLinux 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Mon, 27 May 2002 10:37:47 EDT."
             <a0.2767541f.2a239ebb@aol.com> 
Date: Mon, 27 May 2002 17:18:48 +0200
Message-Id: <20020527151853.212DA11973@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <a0.2767541f.2a239ebb@aol.com> Joachim Martillo wrote:
> 
> Did I say anything about limited resources?  In any case, I have been
> building and designing embedded and turnkey systems for 20 years.
> I would be extremely dubious of any design that passed by my
> desk that proposed the use of a general purpose multiuser,
> multiprocessing, time sliced, preemptive, multimode, virtual
> memory operating system for a digital video recorder.

So what do you recommend when  the  requirement  specification  lists
features as
- Web interface (interface to electronic program guide database)
- network interface (up- / download to normal PC over ethernet)
- IEEE1384 interface (for digital cameras)
- USB interface (for keyboard, printer)
...

Would you start from scratch, or buy component by component, or  just
use Linux?

> > Again, this is not quite  correct.  There  have  been  Real-Time  and
> > Embedded  Unix  systems  before  (LynxOS, to name one). And there are
> > other "common proprietary operating systems" that can be adapted  for
> > embedded needs (WinCE).
> 
> And is there anything that can be done with WinCE or the various
> RT/unix knock-off's that cannot be done better without?

Please let me keep my mouth shut about WinCE.

But yes, there are situations where "the various RT/unix knock-off's"
are the optimal solution (fastest time to market, lowest  cost,  most
features, highest reliability).

> Excuse me, but we are talking embedded systems.  At some
> point there will be copyrighted tradesecreted or patented programs
> in the system.

Maybe. As application. So what?  That  does  not  mean  that  the  OS
kernel, device drivers etc. may not be available under GPL.

> > The problems with Linux  in  Embedded  and  especially  in  Real-Time
> > Systems  are not technical ones. It is the political situation, where
> > the user is left in uncertainty about what he can legally do and what
> > not.
> 
> Easy enough to deal with.  One generates an appropriate real time
> embedded turnkey operating system customized for the embedded 
> turnkey application.  In my experience, it takes about 4-6 weeks
> without disk management and perhaps 8-12 with disk management.

I see. Yes, there are problems of that class. But that's not what I'm
talking about.

> And then one does not have to deal with multimegabytes of
> non-locally produced code that is just lying in wait to cause
> problems.

??? What are you talking about?

> You may need to learn more about doing business in the USA.

Definitely. I learn a lot each day.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If ignorance is bliss, why aren't there more happy people?
