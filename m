Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLUM4G>; Thu, 21 Dec 2000 07:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLUMzz>; Thu, 21 Dec 2000 07:55:55 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:17171 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129325AbQLUMzs>; Thu, 21 Dec 2000 07:55:48 -0500
From: sswapnee@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA2569BC.00442F0D.00@d73mta05.au.ibm.com>
Date: Thu, 21 Dec 2000 17:47:10 +0530
Subject: Mount system call hangs up the system
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everybody

I am trying to mount a filesystem on Linux 2.4.0-test10 kernel using the
mount() function.
When I call this function the system just hangs up.  I have to restart
linux by switching off and on.
Can somebody tell me why mount call just hangs?  Is there anyway to take a
dump when
the call is being executed.

I tried looking for description about mount but couldnt find anything
helpful.  I will really appreciate
if someone can share his/her experience regarding the same.

Thanks and Regards
Swapneel

P.S  Please include my email id in the Cc list as I have not subscribed to
this list.

Swapneel D. Shah
IBM Global Services India Ltd,
email:sswapnee@in.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
