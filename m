Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285188AbRLFUiD>; Thu, 6 Dec 2001 15:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284217AbRLFUh4>; Thu, 6 Dec 2001 15:37:56 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:64261 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285185AbRLFUhi>; Thu, 6 Dec 2001 15:37:38 -0500
Date: Thu, 6 Dec 2001 13:46:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Stephan von Krawczynski <skraw@ithnet.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011206134642.D49@toy.ucw.cz>
In-Reply-To: <20011202155440.F2622@work.bitmover.com> <2379997133.1007402344@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2379997133.1007402344@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Mon, Dec 03, 2001 at 05:59:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > cases.  Yet changes go into the system for 8 way and 16 way performance.
> > That's a mistake.
> > 
> > I'd be ecstatic if the hackers limited themselves to what was commonly 
> > available, that is essentially what I'm arguing for.  
> 
> We need a *little* bit of foresight. If 4 ways are common now, and 8 ways 
> and 16 ways are available, then in a year or two 8 ways (at least) will be
> commonplace. On the other hand 128 cpu machines are a way off, and 
> I'd agree we shouldn't spend too much time on them right now.

90% developers have more than one machine to play with... So maybe there's
time for mosix to be merged...?

Then we can create memnet (netdevice over shared memory), and Larry's dream
can come true...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

