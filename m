Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272482AbTHFUmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272485AbTHFUmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:42:35 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:59279 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272482AbTHFUme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:42:34 -0400
Date: Wed, 06 Aug 2003 16:42:26 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL] Bugzilla bug # 1043 - help message for
 CONFIG_REISERFS_FS is outdated
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308061642.26925.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty self explanatory...The URLs should not be pointing to www.reiserfs.org since
that has been turned into an ad site.

Josef 'Jeff' Sipek

--- linux-2.6.0-test2-vanilla/fs/Kconfig	2003-07-27 13:03:14.000000000 -0400
+++ linux-2.6.0-test2-js/fs/Kconfig	2003-08-06 16:08:03.000000000 -0400
@@ -210,7 +210,7 @@
 
 	  In general, ReiserFS is as fast as ext2, but is very efficient with
 	  large directories and small files.  Additional patches are needed
-	  for NFS and quotas, please see <http://www.reiserfs.org/> for links.
+	  for NFS and quotas, please see <http://www.namesys.com/> for links.
 
 	  It is more easily extended to have features currently found in
 	  database and keyword search systems than block allocation based file
@@ -218,7 +218,7 @@
 	  plugins consistent with our motto ``It takes more than a license to
 	  make source code open.''
 
-	  Read <http://www.reiserfs.org/> to learn more about reiserfs.
+	  Read <http://www.namesys.com/> to learn more about reiserfs.
 
 	  Sponsored by Threshold Networks, Emusic.com, and Bigstorage.com.
 

