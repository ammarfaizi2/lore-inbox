Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbREPXkM>; Wed, 16 May 2001 19:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262142AbREPXkC>; Wed, 16 May 2001 19:40:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262141AbREPXjo>; Wed, 16 May 2001 19:39:44 -0400
Message-ID: <3B030F86.EDA45D1A@transmeta.com>
Date: Wed, 16 May 2001 16:38:46 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg>
		<200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<3B02D6AB.E381D317@transmeta.com>
		<200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca>
		<3B02DD79.7B840A5B@transmeta.com>
		<200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca>
		<3B02F2EC.F189923@transmeta.com>
		<20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
		<3B02FBA6.86969BDE@transmeta.com>
		<200105162303.f4GN3n212178@vindaloo.ras.ucalgary.ca>
		<3B030C76.40BB4558@transmeta.com> <200105162337.f4GNb0j12743@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Erm, let's start again. My central point is that you can use devfs
> names to reliably figure out what kind of device a FD is, as a cleaner
> alternative to comparing major numbers. Therefore, I'm challenging the
> notion that you need to reserve magic major numbers in order to
> distinguish devices.
> 

Noone in this tree has made that claim.  Everyone agree it's butt-ugly. 
However, your solution is by and large just as butt-ugly.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
