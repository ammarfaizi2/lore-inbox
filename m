Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264291AbRFHTNB>; Fri, 8 Jun 2001 15:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264256AbRFHTMw>; Fri, 8 Jun 2001 15:12:52 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:52892 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263660AbRFHTMc>; Fri, 8 Jun 2001 15:12:32 -0400
Subject: Announcing Journaled File System (JFS)  release 0.3.4 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF66A9EF33.B8091BB4-ON85256A65.0069430B@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 8 Jun 2001 14:12:28 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/08/2001 03:12:29 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.3.4 of JFS was made available today.

Drop 34 on June 8, 2001 (jfs-0.3.4-patch.tar.gz) includes fixes to the
file system and utilities. There is now a patch being provided that
will make it easier to move from release 0.3.3 to 0.3.4, the patch file
is call jfs-0_3_3-to-0_3_4.patch.gz.

Function and Fixes in release 0.3.4

 - fsck fix to handle pre-existing lost+found sub dir
 - Fixed to remove a hang waiting on inode (jitterbug #73)
 - Fixed dbench hang on SMP 8-way
 - Fixed a log sync problem, improved performance with this fix

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/jfs



