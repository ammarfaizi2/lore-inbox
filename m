Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRHKRZR>; Sat, 11 Aug 2001 13:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268599AbRHKRZH>; Sat, 11 Aug 2001 13:25:07 -0400
Received: from lanm-pc.com ([64.81.97.118]:1271 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S268598AbRHKRYz>;
	Sat, 11 Aug 2001 13:24:55 -0400
Date: Sat, 11 Aug 2001 13:22:09 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Heil <kerndev@sc-software.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
Message-ID: <20010811132209.A11076@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Heil <kerndev@sc-software.com>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010811125035.A6428@thyrsus.com> <Pine.LNX.3.95.1010811100610.565O-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010811100610.565O-100000@scsoftware.sc-software.com>; from kerndev@sc-software.com on Sat, Aug 11, 2001 at 10:09:07AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Heil <kerndev@sc-software.com>:
> You might try a heat sink & fan on the north bridge chip.
> Also your cpu fans ought to be of the 7+K RPM variety.

Interesting.  We're going to put Silverados on the CPUs as soon as we
can get them -- if you don't know what those are, they're a super-well-
designed cooler that can chill a chip by 24 degrees centigrade.  Low-noise,
too, they only emit 37dBA.

Where is the north bridge chip on the board?  I have the mobo diagram from the
Tyan site but it doesn't show that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Americans have the will to resist because you have weapons. 
If you don't have a gun, freedom of speech has no power.
         -- Yoshimi Ishikawa, Japanese author, in the LA Times 15 Oct 1992
