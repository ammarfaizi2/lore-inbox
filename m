Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbRADKya>; Thu, 4 Jan 2001 05:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131195AbRADKyU>; Thu, 4 Jan 2001 05:54:20 -0500
Received: from mta13-acc.tin.it ([212.216.176.44]:11999 "EHLO fep13-svc.tin.it")
	by vger.kernel.org with ESMTP id <S129977AbRADKyD>;
	Thu, 4 Jan 2001 05:54:03 -0500
Message-ID: <3A546385.C50B1092@tin.it>
Date: Thu, 04 Jan 2001 11:50:29 +0000
From: "A.D.F." <adefacc@tin.it>
Reply-To: adefacc@tin.it
Organization: Private
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Confirmation request about new 2.4.x. kernel limits
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I would like to know whether following limits are right for kernel
2.4.x:

Max. N. of CPU:			32	(SMP)
Max. CPU speed:			> 2 Ghz	(up to ?)
Max. RAM size:			64 GB	(any slowness accessing RAM over 4 GB
					 with 32 bit machines ?)
Max. file size:	 		1 TB	(?)
Max. file system size:		2 TB	(?)
Max. N. of files per FS:	2^32	(depending on max. n. of inodes ?)
Max. N. of users/groups:	2^32	(well, that's in theory, probably 						
practical limits, due to RAM usage,
					 access time, etc., are much lower).

Other upper limits, eventually compared with those of latest 2.2.x
kernels, would be appreciated.

	Thanks in advance for your patience.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
