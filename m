Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317408AbSFHNsY>; Sat, 8 Jun 2002 09:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317407AbSFHNsX>; Sat, 8 Jun 2002 09:48:23 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:18442 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S317406AbSFHNsV>; Sat, 8 Jun 2002 09:48:21 -0400
Date: Sat, 8 Jun 2002 23:50:27 +1000
From: john slee <indigoid@higherplane.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020608135027.GF27429@higherplane.net>
In-Reply-To: <E17FQzQ-0001T2-00@starship> <Pine.LNX.4.44.0206050800140.2614-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 08:51:27AM -0500, Oliver Xymoron wrote:
> > In the context of an mp3 playback system, worrying about whether the
> > controls are realtime seems a little excessive.
> 
> Perhaps you've never been a DJ..

spot on.  this is why i use a dsp card on my studio workstation; latency
doesn't change (therefore no clicks/pops) when you move the mouse
rapidly.  it sticks right on whatever i set it to (13ms on my card, the
newer ones can do around 1ms)

can't say the same for vst (host cpu powered) instruments/effects.
controller latency DOES matter.

sadly all the host software for the card needs windows or macos.  linux
is MUCH better than windows in areas like this, after all the work Sir
Morton has done to clean up latency.  a thousand blessings upon his
house :-)

j.

-- 
toyota power: http://indigoid.net/
