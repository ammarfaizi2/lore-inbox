Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRCKIiS>; Sun, 11 Mar 2001 03:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131381AbRCKIiJ>; Sun, 11 Mar 2001 03:38:09 -0500
Received: from aic.ee.ndhu.edu.tw ([203.64.105.113]:25472 "EHLO
	aic.ee.ndhu.edu.tw") by vger.kernel.org with ESMTP
	id <S131380AbRCKIh7>; Sun, 11 Mar 2001 03:37:59 -0500
Date: Sun, 11 Mar 2001 16:37:10 +0800
From: ³¯¤ý®i <cwz@aic.ee.ndhu.edu.tw>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: About DC-315U scsi driver
Message-Id: <20010311163710.11a86b52.cwz@aic.ee.ndhu.edu.tw>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.4.2-ac17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All.....

Maybe I post at wrong place.....sorry

The driver has not to be included in officeal kernel.
And the maintainer has not updated the driver from 2.4.0-test9-pre7.
Maybe he is very busy.The last update is 2000-12-03.

I used some kernels from 2.4.0 to 2.4.2-ac17,and the driver always go wrong
when I burn CDRs. Some files burned is different from the origin at HD.
I use 2.2.17 with Tekram's driver,and nothing is wrong.
I think the scsi layer maybe changed from 2.2.x,so the driver cannot run well.
I am sure the hardware&software is ok,and no error messages about scsi  found by me. 

Can anyone do me a favor to modify the driver in order to suite the
new kernel?

Thanks....

And some resources can be found at http://www.garloff.de/kurt/linux/dc395/.

Best Regards,cwz
