Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284210AbRLASO5>; Sat, 1 Dec 2001 13:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284196AbRLASOr>; Sat, 1 Dec 2001 13:14:47 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:52477 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284203AbRLASO3>; Sat, 1 Dec 2001 13:14:29 -0500
Message-Id: <5.1.0.14.2.20011201181316.00b0a400@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 01 Dec 2001 18:14:16 +0000
To: "H. Peter Anvin" <hpa@zytor.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Incremental prepatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C089BDB.4020801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:59 01/12/01, H. Peter Anvin wrote:
>I have created a robot on kernel.org which makes incremental prepatches 
>available.

Fantastic! Thanks! Finally I can stop doing the diffs myself. (-:

Best regards,

         Anton

>It looks for standard-named prepatches in the 
>/pub/linux/kernel/v*.*/testing directories, and creates incrementals in 
>the corresponding /pub/linux/kernel/v*.*/testing/incr directory.
>
>For example:
>
>hera 86 % cd /pub/linux/kernel/v2.5/testing/incr/
>hera 87 % ls -l *.gz
>-rw-rw-r--    1 kdist    kernel     177158 Nov 27 10:17 
>patch-2.5.1-pre1-pre2.gz
>-rw-rw-r--    1 kdist    kernel     102202 Nov 28 15:35 
>patch-2.5.1-pre2-pre3.gz
>-rw-rw-r--    1 kdist    kernel      52955 Nov 29 15:29 
>patch-2.5.1-pre3-pre4.gz
>-rw-rw-r--    1 kdist    kernel      53616 Nov 30 17:04 
>patch-2.5.1-pre4-pre5.gz
>
>The naming and function of the patches should be obvious.
>
>.bz2 and .sign files are available too, of course.
>
>         -hpa
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

