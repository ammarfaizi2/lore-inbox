Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSDQUFd>; Wed, 17 Apr 2002 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313668AbSDQUFc>; Wed, 17 Apr 2002 16:05:32 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:47129 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313384AbSDQUFb>; Wed, 17 Apr 2002 16:05:31 -0400
Message-Id: <5.1.0.14.2.20020417210154.00adde30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Apr 2002 21:05:21 +0100
To: John Covici <covici@ccs.covici.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.8 nbd.c doesn't compile
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m33cxuw23g.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation is already fixed in the current bitkeeper tree 
(linux.bkbits.net/linux-2.5). so you can either get that or you can apply 
the patch I posted this morning fixing this problem.

You can find the patch in the archives:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101897350106638&w=2

Note patch compiles but is otherwise untested.

Best regards,

Anton

At 20:34 17/04/02, John Covici wrote:
>When I try to compile 2.5.8 with nbd as a module, I get lots of error
>saying structure has no member queue_lock .
>
>Any assistance would be appreciated.
>
>--
>          John Covici
>          covici@ccs.covici.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

