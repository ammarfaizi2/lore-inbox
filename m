Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287237AbSASMsS>; Sat, 19 Jan 2002 07:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSASMr4>; Sat, 19 Jan 2002 07:47:56 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:2751 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287237AbSASMrr>; Sat, 19 Jan 2002 07:47:47 -0500
Message-Id: <5.1.0.14.2.20020119051141.050485d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 19 Jan 2002 12:48:06 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Linux 2.5.3-pre1-aia2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another IDE core update from Andre. IDE core continues to be fully stable 
in my tests.

Patch available from:

http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.5.3-pre1-aia2
http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.5.3-pre1-aia2.bz2
http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.5.3-pre1-aia2.gz

Linux 2.5.3-pre1-aia2

o       IDE core updates                        (Andre Hedrick)
o       RAID fixes                              (from 2.4.18-pre4)
o       Fix compile warnings                    (me)

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

