Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265580AbRFVXc1>; Fri, 22 Jun 2001 19:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbRFVXcR>; Fri, 22 Jun 2001 19:32:17 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:47288 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265575AbRFVXcI>; Fri, 22 Jun 2001 19:32:08 -0400
Subject: Announcing Journaled File System (JFS)  release 0.3.6 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF0CEAEED5.91C32014-ON85256A73.00723C0E@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 22 Jun 2001 18:32:06 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/22/2001 07:32:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.3.6 of JFS was made available today.

Drop 36 on June 22, 2001 (jfs-0.3.6-patch.tar.gz) includes fixes to the
file system and utilities. There is now a patch being provided that will
make it easier to move from release 0.3.5 to 0.3.6, the patch file
is call jfs-0_3_5-to-0_3_6.patch.gz.

Function and Fixes in release 0.3.6

- Fixed jitterbug problem # 10 rm -rf fails on a big directory

For more details about the problems fixed, please see the README.


Steve
JFS for Linux http://oss.software.ibm.com/jfs

