Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSDXLvJ>; Wed, 24 Apr 2002 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSDXLvI>; Wed, 24 Apr 2002 07:51:08 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:49264 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S311866AbSDXLvH>; Wed, 24 Apr 2002 07:51:07 -0400
Message-Id: <5.1.0.14.2.20020424124953.03cde900@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 24 Apr 2002 12:51:45 +0100
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Anton Altaparmakov <aia21@cantab.net>
Subject: ANN: NTFS 2.0.2 for kernel 2.5.9 released
Cc: linux-ntfs-dev@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

NTFS 2.0.2 for kernel 2.5.9 is now available. This is a small update mainly 
to incorporate kernel 2.5.9. Also the default fmask is changed to 0177 
which means files do not get the executable bit by default. The majority of 
users prefer it this way. Minor misc bug fixes. Updating is recommended and 
is necessary if you want to use kernel 2.5.9. Note the patch will work with 
2.5.7, too but it may not apply cleanly so you may have to do some minimal 
& obvious patch work yourself.

You can download patches for kernel 2.5.9 from Sourceforge:

http://linux-ntfs.sf.net/downloads.html

And of course you can use BitKeeper to get our BitKeeper repository at:
         http://linux-ntfs.bkbits.net/ntfs-tng-2.5

And a on-line view of the repository is available here:
         http://linux-ntfs.bkbits.net:8080/ntfs-tng-2.5

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

