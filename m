Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTARQfS>; Sat, 18 Jan 2003 11:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTARQfR>; Sat, 18 Jan 2003 11:35:17 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:22931 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264910AbTARQfR>; Sat, 18 Jan 2003 11:35:17 -0500
Date: Sat, 18 Jan 2003 16:44:17 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: linux-ntfs-dev@lists.sf.net
cc: linux-kernel@vger.kernel.org
Subject: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
Message-ID: <Pine.SOL.3.96.1030118163630.27974A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to announce the new release of the ntfsprogs package (formerly
Linux-NTFS).

This is a massive update featuring an almost complete rewrite of the ntfs
library (the API should hopefully remain stable from now on) as well as
several new utilities: ntfslabel, ntfsresize, and ntfsundelete.

Note this is a beta release and can contain bugs. Please backup your data
before using any of the utilities in write mode. 

You can download the source code as a tar ball or source rpm or binary
rpms for intel 386 architecture from our website:

	http://linux-ntfs.sourceforge.net/downloads.html

Or you can get the latest source from our bitkeeper repository by doing a:

	bk clone http://linux-ntfs.bkbits.net/ntfsprogs

You can also browse the source code online here:

	http://linux-ntfs.bkbits.net:8080/ntfsprogs

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

