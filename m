Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265395AbRF0UGf>; Wed, 27 Jun 2001 16:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbRF0UGZ>; Wed, 27 Jun 2001 16:06:25 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:59414 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265395AbRF0UGN>; Wed, 27 Jun 2001 16:06:13 -0400
From: joeja@mindspring.com
Date: Wed, 27 Jun 2001 16:06:11 -0400
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alex Deucher <adeucher@UU.NET>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: AMD thunderbird oops
Message-ID: <Springmail.105.993672371.0.48374000@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well considering the other night the power supply went dead, I think that is part of the problem.  It is brand new, and I am being sent another one (free of course).  

I also had my mb loaded at the time (scsi cd-rw, cdrom, internal zip, floppy, 1 hd, Sound card, video, modem, NIC, scsi card) but my last tyan was fine with that load it may be a kt7a thing. 

Several people said that random (keyword here) oopses are more often a hardware thing.  I wonder if the kt7a is going to be able to perform  fully loaded.. 

is anyone running one fully loaded? 4 ide drives, 2 floppy, (5 pci and 1 isa) or 6pci, agp, 512MEG+ RAM?

Joe 

Dave Jones <davej@suse.de> wrote:
> On Tue, 26 Jun 2001, Alan Cox wrote:
> My current speculation is that the sdram setup on some of these boards can't
> actually take the full CPU spec caused by these hand tuned routines. There is
> some evidence to support that as several other boards only work with Athlon
> optimisation if you set the BIOS options to 'conservative' not 'optimised'

Interesting, and plausable theory. It would be more interesting to see
register dumps of the memory timing registers on both good and bad
systems, to see if this is the case.

Unfortunatly afair the register level specs of all the affected chipsets
are not available.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs


