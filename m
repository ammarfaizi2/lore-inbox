Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCGTyx>; Wed, 7 Mar 2001 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRCGTyo>; Wed, 7 Mar 2001 14:54:44 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:14789 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129197AbRCGTya>; Wed, 7 Mar 2001 14:54:30 -0500
Importance: Normal
Subject: Announcing Journaled  File System (JFS)  beta 2 release 0.2.0 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Steve Best" <sbest@us.ibm.com>
Date: Wed, 7 Mar 2001 14:54:01 -0500
Message-ID: <OFAA131B69.E61F02FD-ON85256A08.006CC071@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 03/07/2001 02:54:05 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The beta 2 drop of JFS was made available today.

The file system has fixes included.
In the utility area there is new jfsprogs.spec file
created by Jim Nance. This spec file can be used to create
RPM for the JFS utilities. The file system has general work
done to remove SMP and UP hang related problems. The performance
of the file system has increased by changes to extent inode cache,
also the log manager is no longer uses the page cache for log pages
and this change has increased the performance of the file system.
Joe Nuspl patches have also been included in this drop for the
problems he has found/fixed.

Jim and Joe thanks for your changes.

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/developerworks/opensource/jfs

