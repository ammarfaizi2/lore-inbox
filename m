Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280363AbRJaRwC>; Wed, 31 Oct 2001 12:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280364AbRJaRvx>; Wed, 31 Oct 2001 12:51:53 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:30111 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280363AbRJaRvr>; Wed, 31 Oct 2001 12:51:47 -0500
Message-Id: <5.1.0.14.2.20011031174516.00abb140@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 31 Oct 2001 17:51:50 +0000
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: EM8400/8401 support?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0110311711050.27627-100000@mustard.heime.net
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.sigmadesigns.com/support/download_netstream2000_linux.htm

contains official binary only drivers for the Netstream2000 card which uses 
the em8400 chip.

If you are using the chip to implement your own board then you should 
contact sigma designs for Linux drivers. They say the chip has linux 
support on:

http://www.sigmadesigns.com/products/em8400.htm

As Sigma designs do not release specs nor sourcecode there is no open 
source driver available and I am not aware of any non-official efforts to 
produce drivers.

If you want the em8300 chip then have a look at http://dxr3.sf.net/ where 
you can find the inofficial Linux GPL drivers for the Sigma designs 
Realmagic Hollywood+ and Creative dxr3 cards (which are the same).

HTH,

Anton

At 16:12 31/10/01, Roy Sigurd Karlsbakk wrote:
>hi
>
>Are there currently any official kernel support for the Sigma 8400/8401
>chips?
>I need this...
>
>Please cc: to me as I'm not on the list
>
>roy
>
>---
>Praktiserende dyslektiker.
>La ikke ortografiske krumspring skygge for
>intensjonen bak denne fremstilling.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

