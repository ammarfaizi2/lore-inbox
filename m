Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291400AbSBHEw0>; Thu, 7 Feb 2002 23:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291402AbSBHEwQ>; Thu, 7 Feb 2002 23:52:16 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:22490 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291400AbSBHEwB>; Thu, 7 Feb 2002 23:52:01 -0500
Message-Id: <5.1.0.14.2.20020208045006.00b2e4d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 04:52:23 +0000
To: Dave Jones <davej@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: linux 2.5.4-pre3 and IDE changes
Cc: Skip Ford <skip.ford@verizon.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202080508410.29741-100000@Appserv.suse.de>
In-Reply-To: <20020208035851.KOPJ10804.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:10 08/02/02, Dave Jones wrote:
>On Thu, 7 Feb 2002, Skip Ford wrote:
>
> > This is the patch that Jens posted, though he posted it before this
> > kernel was even released.  His post said it fixed a compile error
> > in pre2, but pre2 compiled fine.  It _does_ fix the compile error in
> > pre3 though.
>
>As more developers start pulling Linus' bitkeeper tree, you'll probably
>see more bugs getting fixed before they're reported 8-)

Ah, but taking this one step further, most people will never see the bugs 
as the fixes will be applied by Linus before he releases the pending pre 
kernel so the pre kernel won't have the bug. (-8

Only the bk changelog will tell us they ever existed... (-;

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

