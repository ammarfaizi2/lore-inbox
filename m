Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVJDPg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVJDPg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVJDPg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:36:28 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:17624 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964806AbVJDPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:36:27 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 4 Oct 2005 16:36:10 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.14-rc3-git] NTFS: Two final bug fixes.
Message-ID: <Pine.LNX.4.60.0510041634180.28800@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/bitmap.c  |    5 +++--
 fs/ntfs/layout.h  |    2 +-
 fs/ntfs/mft.c     |    3 ++-
 fs/ntfs/unistr.c  |    2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

This contains two more bugfixes for NTFS that need to go in before 2.6.14 
is released.  - Please apply.  Thanks!  - There should really, really not 
be any more for 2.6.14!  Famous really, really, last words...

Diff style patches generated with git format-patch follow as replies to
this email.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
