Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbRHKQxb>; Sat, 11 Aug 2001 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268595AbRHKQxV>; Sat, 11 Aug 2001 12:53:21 -0400
Received: from lanm-pc.com ([64.81.97.118]:21494 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S268582AbRHKQxN>;
	Sat, 11 Aug 2001 12:53:13 -0400
Date: Sat, 11 Aug 2001 12:50:35 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
Message-ID: <20010811125035.A6428@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010811062349.A1769@thyrsus.com> <E15VYfw-0002bu-00@the-village.bc.nu> <20010811123200.F6024@thyrsus.com> <20010811124409.Y3126@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010811124409.Y3126@sventech.com>; from johannes@erdfelt.com on Sat, Aug 11, 2001 at 12:44:09PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt <johannes@erdfelt.com>:
> > different design?  Because the K7 Thunder is, AFAIK, the only dual-Athlon
> > 1200 board that exists right now.  
> 
> I suspect he means same design, different physical hardware.

Yes, he said so in a reply.
 
> > 2. Do you know of anyone else successfully running 2.4 over an AMD 760
> > support chipset?
> 
> I am.
> 
> I have had some cooling problems with some of the hardware in the past.
> 
> > 3. Which components do you think are likely to be implicated?  Bad memory
> > is an obvious guess, I suppose.
> 
> Cooling most likely. What kind of system is this? Rackmount? Desktop
> case?

Server case.  Seems to be running pretty cool -- the processor heatsinks
are warm to the touch but not hot.  We've got a power-supply fan, two coolers,
and two case fans.  Did you find you needed more than that?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

There's a truism that the road to Hell is often paved with good intentions.
The corollary is that evil is best known not by its motives but by its
*methods*.
