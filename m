Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbRBZX3W>; Mon, 26 Feb 2001 18:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRBZX3N>; Mon, 26 Feb 2001 18:29:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22925 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129215AbRBZX3D>; Mon, 26 Feb 2001 18:29:03 -0500
Importance: Normal
Subject: Announcing Journaled File System (JFS) release 0.1.6
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Steve Best" <sbest@us.ibm.com>
Date: Mon, 26 Feb 2001 18:28:26 -0500
Message-ID: <OFAB16E6C3.201BF1B2-ON852569FF.007FAB2F@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 02/26/2001 06:28:50 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest drop of JFS was made available today.

The file system has fixes included.
The log manager no longer uses the page cache for log pages, this
eliminates dead-locks that were occurring in the log manager. The file system has
general work done to remove SMP dead-lock problems. fsck now supports default
values passed by fstab correctly. For more details about the problems
fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/developerworks/opensource/jfs

