Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBWTzM>; Fri, 23 Feb 2001 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130028AbRBWTyy>; Fri, 23 Feb 2001 14:54:54 -0500
Received: from [216.184.166.130] ([216.184.166.130]:51804 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S129134AbRBWTyh>; Fri, 23 Feb 2001 14:54:37 -0500
Date: Fri, 23 Feb 2001 11:50:24 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: ian@wehrman.com, mhaque@haque.net, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <E14WNrA-0006vM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010223114735.19559B-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Alan Cox wrote:

> Date: Fri, 23 Feb 2001 19:26:17 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: ian@wehrman.com
> Cc: mhaque@haque.net, adilger@turbolinux.com, linux-kernel@vger.kernel.org
> Subject: Re: EXT2-fs error
> 
> > > Possibly the result of the 'silent' bug in 2.4.1?
> > 
> > you are not the only one who found this bug. immediately after booting 2.4.2 i
> > received dozens of these errors, resulting in _major_ filesystem corruption.
> > after a half hour of fsck'ing i managed to bring the machine back into a usable
> 
> Had you been running 2.4.1 before that ?

I had, and received a bit different corruption involving inode and block
bitmap errors rather than directories... ac19 seems so far to have solved
it.


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
kerndev@sc-software.com
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

