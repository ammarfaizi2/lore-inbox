Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290534AbSARC16>; Thu, 17 Jan 2002 21:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290514AbSARC1s>; Thu, 17 Jan 2002 21:27:48 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:7557 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S290534AbSARC1e>; Thu, 17 Jan 2002 21:27:34 -0500
Message-Id: <5.1.0.14.2.20020118021222.04e4caa0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 18 Jan 2002 02:27:45 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Linux 2.5.3-pre1-aia1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new IDE core from Andre is now solid as reported by various 
people on IRC, here is my local patch (stable for me) which you can apply 
to play with the shiny new IDE core (IDE core fix is same as 
ata-253p1-2.bz2 from Jens). (-:

Patch available from:

http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.5.3-pre1-aia1
http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.5.3-pre1-aia1.bz2
http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.5.3-pre1-aia1.gz

Linux 2.5.3-pre1-aia1

o       Fix new IDE core                        (Jens Axboe, Andre Hedrick)
+       Configure help entries for IDE          (Andre Hedrick, Rob Radez, me)
+       Reduce NTFS vmalloc use (NTFS 1.1.22)   (me)
o       Compile fixes for dnotify               (me)
o       Compile fixes for via82cxxx             (me)

Patches marked "+" have been submitted to Linus by me already.

Enjoy,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

