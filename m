Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUHZEVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUHZEVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUHZEVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:21:51 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:56742 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267415AbUHZEVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:21:49 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Thu, 26 Aug 2004 04:21:48 +0000
Message-Id: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That incredibly useful patch for 2.4.X that Andrea wrote that splits the kernel user space 
into 1GB/2GB/3GB sections  I ported to 2.6.8.1 and posted it to:

ftp.kernel.org:/pub/linux/kernel/people/jmerkey/patches/linux-2.6.8.1-highmem-split-08-25-04.patch

I was not able to located a 2.6.8 version of this patch so I ported one.  I apologize in advance
if I replicated anyone elses work.

Using HIGHMEM (aka.  the extended Linux TLB reloading hits/second test) is not optimal for embedded systems and appliance versions of Linux we use so this is submitted.  I'll maintain
this patch (and keep it working) for folks who need it.

Would be nice to have in the kernel for appliance Linux.

** I CERTIFY THAT THIS CODE DOES NOT CONTAIN ANY INTELECTUAL PROPERTY 
OF ANYONE OTHER THAN THE ORIGINAL LINUX CONTRIBUTORS THE FILES
WERE DERIVED FROM. ***

Jeff V. Merkey

