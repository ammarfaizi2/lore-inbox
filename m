Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292201AbSBBCom>; Fri, 1 Feb 2002 21:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292202AbSBBCoc>; Fri, 1 Feb 2002 21:44:32 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:29073 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S292201AbSBBCo0>; Fri, 1 Feb 2002 21:44:26 -0500
Message-Id: <5.1.0.14.2.20020202024047.050c5ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 02 Feb 2002 02:44:40 +0000
To: Andreas Dilger <adilger@turbolabs.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Cc: "Axel H. Siebenwirth" <axel@hh59.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020201105234.D763@lynx.adilger.int>
In-Reply-To: <20020201164813.GA14296@neon>
 <20020201153303.A1508@prester.hh59.org>
 <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk>
 <20020201164813.GA14296@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:52 01/02/02, Andreas Dilger wrote:
>On Feb 01, 2002  17:48 +0100, Axel H. Siebenwirth wrote:
> > P.S.: Would like to write to my WinXP NTFS Partition, is there some hope MS
> > will ever give out exact specs (they don't, do they?)

No.

> > to have write
> > funtionality properly implemented? Is there some other way to contribute?
>
>Try out the ntfs-tng driver at sourceforge.net.  It is your best bet.

Yes, ntfs-tng currently is read-only pending completion soon-ish. Once it 
is complete and in the kernel write support development will start immediately.

If you (or anyone else) would like to contribute, please download the 
latest ntfs-driver-tng module from the linux-ntfs cvs (see 
http://linux-ntfs.sf.net/) and have a look at the code. You can direct any 
questions/comments/etc about the code to the mailing list: 
linux-ntfs-dev@lists.sf.net

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

