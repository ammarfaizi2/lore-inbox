Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbREXKqX>; Thu, 24 May 2001 06:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbREXKqN>; Thu, 24 May 2001 06:46:13 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:52126 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261302AbREXKqD>; Thu, 24 May 2001 06:46:03 -0400
Message-Id: <5.1.0.14.2.20010524114546.00aadd30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 May 2001 11:46:29 +0100
To: Blesson Paul <blessonpaul@usa.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: How to add NTFS support
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:20 24/05/2001, Blesson Paul wrote:
>      I have redhat6.2. I have to add ntfs support to it(defaultly
>    it do not have). I know to do it by changing the configuration and
>    recompiling the whole kernel. I want to know , is there any method to
>register ntfs file system without recompiling the whole kernel

 >No, it is not possible to not recompile the kernel if NTFS was configured.

I meant "was not configured"...

Anton


You might see some very strange effects if you try... What is your problem? 
Just recompile the kernel. Remember NTFS should be used read-only as write 
support is broken.

I have a much improved NTFS driver but my Sourceforge linux-NTFS CVS is 
down (for a week now!) so I can't release it at the moment. )-:

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

