Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312885AbSDULDf>; Sun, 21 Apr 2002 07:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSDULDe>; Sun, 21 Apr 2002 07:03:34 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:57395 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312885AbSDULDd>; Sun, 21 Apr 2002 07:03:33 -0400
Subject: [bk2.5 patchlet] Update URL for NBD.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 21 Apr 2002 12:03:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16zF80-0003LF-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please apply below patch updating the URL in the NBD documentation to point
to the project home page on sourceforge.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- nbd25.patch ---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.557   -> 1.558  
#	Documentation/nbd.txt	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/21	aia21@cantab.net	1.558
# Update NBD URL in documentation.
# --------------------------------------------
#
diff -Nru a/Documentation/nbd.txt b/Documentation/nbd.txt
--- a/Documentation/nbd.txt	Sun Apr 21 12:01:09 2002
+++ b/Documentation/nbd.txt	Sun Apr 21 12:01:09 2002
@@ -54,4 +54,4 @@
   ...                 in case of read operation with no error,
                       this is immediately followed len bytes of data
 
-   For more information, look at http://atrey.karlin.mff.cuni.cz/~pavel.
+   For more information, look at http://nbd.sf.net/.
