Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbRESPkq>; Sat, 19 May 2001 11:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbRESPk1>; Sat, 19 May 2001 11:40:27 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:15312 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261835AbRESPkU>; Sat, 19 May 2001 11:40:20 -0400
Message-Id: <5.1.0.14.2.20010519163616.00aaa0b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 19 May 2001 16:40:21 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Q: ioctl BLKGETSIZE return value units?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What are the units of the return value of the BLKGETSIZE ioctl on Linux?

Is it allways in units of 512 bytes or is it in units of sector size bytes 
as returned by BLKSSZGET ioctl?

Thanks in advance.

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

