Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268596AbRHKRLz>; Sat, 11 Aug 2001 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRHKRLp>; Sat, 11 Aug 2001 13:11:45 -0400
Received: from [206.40.202.198] ([206.40.202.198]:57716 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S268596AbRHKRL3>; Sat, 11 Aug 2001 13:11:29 -0400
Date: Sat, 11 Aug 2001 10:09:07 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
In-Reply-To: <20010811125035.A6428@thyrsus.com>
Message-ID: <Pine.LNX.3.95.1010811100610.565O-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001, Eric S. Raymond wrote:

> Date: Sat, 11 Aug 2001 12:50:35 -0400
> From: "Eric S. Raymond" <esr@thyrsus.com>
> To: Johannes Erdfelt <johannes@erdfelt.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
>     Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
> 
> Johannes Erdfelt <johannes@erdfelt.com>:
> > > different design?  Because the K7 Thunder is, AFAIK, the only dual-Athlon
> > > 1200 board that exists right now.  
> > 
> > I suspect he means same design, different physical hardware.
> 
> Yes, he said so in a reply.
>  
> > > 2. Do you know of anyone else successfully running 2.4 over an AMD 760
> > > support chipset?
> > 
> > I am.
> > 
> > I have had some cooling problems with some of the hardware in the past.
> > 
> > > 3. Which components do you think are likely to be implicated?  Bad memory
> > > is an obvious guess, I suppose.
> > 
> > Cooling most likely. What kind of system is this? Rackmount? Desktop
> > case?
> 
> Server case.  Seems to be running pretty cool -- the processor heatsinks
> are warm to the touch but not hot.  We've got a power-supply fan, two coolers,
> and two case fans.  Did you find you needed more than that?

You might try a heat sink & fan on the north bridge chip.
Also your cpu fans ought to be of the 7+K RPM variety.

> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> There's a truism that the road to Hell is often paved with good intentions.
> The corollary is that evil is best known not by its motives but by its
> *methods*.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

