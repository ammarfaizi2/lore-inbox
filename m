Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264993AbRGEMcG>; Thu, 5 Jul 2001 08:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264998AbRGEMb4>; Thu, 5 Jul 2001 08:31:56 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:22229 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264993AbRGEMbw>; Thu, 5 Jul 2001 08:31:52 -0400
Message-Id: <5.1.0.14.2.20010705132933.00ab7d90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 05 Jul 2001 13:31:40 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Kernel HOWTO update?
Cc: spstarr@sh0n.net (Shawn Starr), bri@cs.uchicago.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15I716-0002M5-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.30.0107042313210.4004-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:09 05/07/01, Alan Cox wrote:
> > "Using LILO with big drives (more than 1024 cylinders) can cause problems.
> > See the LILO mini-HOWTO or documentation for help on that."
> >
> > This isn't true anymore unless your using an older version of LILO.
>
>For a large number of BIOSes out there it is still true

Is this still true if you use the lba32 option in lilo.conf?

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

