Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264517AbRFOU0t>; Fri, 15 Jun 2001 16:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264521AbRFOU0j>; Fri, 15 Jun 2001 16:26:39 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21703 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264517AbRFOU0a>; Fri, 15 Jun 2001 16:26:30 -0400
Subject: Announcing Journaled File System (JFS)  release 0.3.5 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4B0C2473.9C1D6552-ON85256A6C.00700F83@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 15 Jun 2001 15:26:25 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/15/2001 04:26:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.3.5 of JFS was made available today.

Drop 35 on June 15, 2001 (jfs-0.3.5-patch.tar.gz) includes fixes to the
file system and utilities. There is now a patch being provided that will
make it easier to move from release 0.3.4 to 0.3.5, the patch file
is call jfs-0_3_4-to-0_3_5.patch.gz.

Function and Fixes in release 0.3.5

- updated fsck error handling
- updated mkfs config options and the man page for fsck
- Increase the performance of unlinking files, most unlinks are done
  asynchronously now
- Fixed "XT_GETPAGE: xtree page corrupt" during creating files on nfs
  mounted partition

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/jfs





