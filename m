Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268599AbRHKRdT>; Sat, 11 Aug 2001 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268609AbRHKRdJ>; Sat, 11 Aug 2001 13:33:09 -0400
Received: from [206.40.202.198] ([206.40.202.198]:60276 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S268599AbRHKRdF>; Sat, 11 Aug 2001 13:33:05 -0400
Date: Sat, 11 Aug 2001 10:30:46 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
In-Reply-To: <20010811132209.A11076@thyrsus.com>
Message-ID: <Pine.LNX.3.95.1010811102416.565Q-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001, Eric S. Raymond wrote:

> Date: Sat, 11 Aug 2001 13:22:09 -0400
> From: "Eric S. Raymond" <esr@thyrsus.com>
> To: John Heil <kerndev@sc-software.com>
> Cc: Johannes Erdfelt <johannes@erdfelt.com>,
>     Alan Cox <alan@lxorguk.ukuu.org.uk>,
>     Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
> 
> John Heil <kerndev@sc-software.com>:
> > You might try a heat sink & fan on the north bridge chip.
> > Also your cpu fans ought to be of the 7+K RPM variety.
> 
> Interesting.  We're going to put Silverados on the CPUs as soon as we
> can get them -- if you don't know what those are, they're a super-well-
> designed cooler that can chill a chip by 24 degrees centigrade.  Low-noise,
> too, they only emit 37dBA.
> 
> Where is the north bridge chip on the board?  I have the mobo diagram from the
> Tyan site but it doesn't show that.

It's the AMD-762 system controller, the one with the metallic cap on top.

> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> Americans have the will to resist because you have weapons. 
> If you don't have a gun, freedom of speech has no power.
>          -- Yoshimi Ishikawa, Japanese author, in the LA Times 15 Oct 1992
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

