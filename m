Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSB0CVh>; Tue, 26 Feb 2002 21:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291539AbSB0CV2>; Tue, 26 Feb 2002 21:21:28 -0500
Received: from cvg-65-27-175-98.cinci.rr.com ([65.27.175.98]:34549 "EHLO
	velma.lathi.net") by vger.kernel.org with ESMTP id <S291102AbSB0CVT>;
	Tue, 26 Feb 2002 21:21:19 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: cs46xx on ThinkPad A22m and poor quality output
In-Reply-To: <87vgcjvs1p.fsf@localhost.localdomain>
X-Url: http://www.lathi.net
X-Face: +GT&`y}rSVHq>&PvSIvtsy^RC6Agyxq)t+25D#'iTroOnA/'pcE$QD*WU1=WLS*OC\0y-kS
 |k+)w~x<On+~nkw**|X{sAHBiS2:_=w#<!?;UWm4|C05osQ8`jpRF+[o!wRPjV`tiTN~i'XXwZz3w=
 7|j)RyEq{~2v;Ht<;!)b'Ni[A{&xm,Myo6+w+#e
Reply-To: doug@lathi.net
From: Doug Alcorn <lathi@seapine.com>
Date: 26 Feb 2002 21:21:11 -0500
In-Reply-To: Doug Alcorn's message of "26 Feb 2002 16:42:26 -0500"
Message-ID: <87pu2r1x7s.fsf@localhost.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (bamboo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Alcorn <lathi@seapine.com> writes:

> The other problem maybe hardware.  Like I said, the sound was
> crystal clear.  Recently, the output sounds like I blew out my
> speakers.  At first I thought it was my crappy headphones.  I
> unplugged the headphones and the internal speakers sound the same
> way.  It's just at the higher-levels of output (when my xmms eq
> display has lines that peak) it sounds fuzzy.  The other interesting
> thing is that streamed audio sounds much worse than my actual mp3
> files. Is it possible the card got smoked?

I hate to follow up to my own post; however, I managed to get the card
working well with the alsa cs46xx driver.  This would imply to me that
it's a bug in the linux kernel driver for the cs46xx (is this referred
to as the oss driver?).

BTW, someone suggested I simply turn the volume down using the
hardware buttons on the keyboard.  The poor sound quality is really
irrespective of the speaker volume.  Maybe this wasn't clear when I
talked about the "higher-levels of output".  I'm not sure about the
right vocabulary.  I guess it's the power output on the individual
frequency bands.
-- 
 (__) Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
 oo / PGP 02B3 1E26 BCF2 9AAF 93F1  61D7 450C B264 3E63 D543
 |_/  If you're a capitalist and you have the best goods and they're
      free, you don't have to proselytize, you just have to wait. 
