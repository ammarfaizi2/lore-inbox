Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270857AbRH1MyB>; Tue, 28 Aug 2001 08:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270855AbRH1Mxv>; Tue, 28 Aug 2001 08:53:51 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:54410 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270857AbRH1Mxj>; Tue, 28 Aug 2001 08:53:39 -0400
Message-Id: <5.1.0.14.2.20010828134152.04eeaa10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 28 Aug 2001 13:53:29 +0100
To: Guest section DW <dwguest@win.tue.nl>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Determining maximum partition size on a hard disk
Cc: nick@guardiandigital.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010828142315.A20775@win.tue.nl>
In-Reply-To: <3B82BCCB.377BCC4@guardiandigital.com>
 <3B82BCCB.377BCC4@guardiandigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:23 28/08/01, Guest section DW wrote:
>On Tue, Aug 21, 2001 at 03:55:55PM -0400, Nick DeClario wrote:
> > I thought maybe Linux set 1MB=1000k but that doesn't seem to case.
>
>Well, 1 M = 1000 k by definition of the SI system of units.
>This has nothing to do with Linux.
>But if you are confused about units, just compute in bytes.

While it is true that M = 10^6 and k = 10^3, surely that doesn't apply to 
byte quantities?!? At least I have always interpreted 1 Megabyte = 1024 
kilobytes = 1024*1024 bytes, and I think the poster meant the same when 
writing 1MB = 1000k...

If we are nitpicking, he probably should have written 1MiB = 1000kiB. [Feel 
free to correct me if I am wrong, but IIRC, Mi and ki are the abbreviations 
for 2^10 multiples rather than 10^3...]

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

