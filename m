Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282906AbRLIDIv>; Sat, 8 Dec 2001 22:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282910AbRLIDIl>; Sat, 8 Dec 2001 22:08:41 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:3474 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282906AbRLIDIc>; Sat, 8 Dec 2001 22:08:32 -0500
Date: Sat, 8 Dec 2001 20:08:23 -0700
Message-Id: <200112090308.fB938N504764@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rene Rebe <rene.rebe@gmx.net>, linux-kernel@vger.kernel.org,
        alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <3C1128A6.E6F656AF@linux-m68k.org>
In-Reply-To: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0112071617440.2935-100000@serv>
	<200112071559.fB7FxwR14021@vindaloo.ras.ucalgary.ca>
	<3C1115CD.FD2858EC@linux-m68k.org>
	<200112072008.fB7K8hA18586@vindaloo.ras.ucalgary.ca>
	<3C1128A6.E6F656AF@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> Richard Gooch wrote:
> 
> > Tell me how the driver no longer works. I repeat: you now get a
> > warning. You can still use the driver.
> 
> devfs_mk_dir returns an error now, so the driver won't be able to
> make new dev nodes available. So far it was legal to manually create
> a directory under devfs, now it's suddenly an error.

It was always an error, you just got away with it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
