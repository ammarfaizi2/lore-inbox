Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTBXLC3>; Mon, 24 Feb 2003 06:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBXLC3>; Mon, 24 Feb 2003 06:02:29 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:52151 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266443AbTBXLC1>; Mon, 24 Feb 2003 06:02:27 -0500
Date: Mon, 24 Feb 2003 11:12:39 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
Reply-To: Anton Altaparmakov <aia21@cantab.net>
To: linux-kernel@vger.kernel.org
cc: linux-ntfs-dev@lists.sourceforge.net
Subject: [ANN] NTFS 2.1.1a for kernel 2.4.20 released
Message-ID: <Pine.SOL.3.96.1030224111049.22477D-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS 2.1.1a is now released for kernel 2.4.20. This fixes both the
reported hangs and improves the handling of compressed files so that the
warning message people keep reporting is now gone. (Note the hangs were
specific to the 2.4.x kernel ntfs versions. 2.5.x kernel ntfs versions
are not affected.)

Download the patch from:

        http://linux-ntfs.sf.net/downloads.html

Or get from our BK repository (which is at the current BK linux-2.4
version, i.e. 2.4.21-pre4-bk):

        bk://linux-ntfs.bkbits.net/ntfs-2.4

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


