Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275929AbTHOMcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275930AbTHOMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:32:22 -0400
Received: from angband.namesys.com ([212.16.7.85]:56487 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275929AbTHOMcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:32:20 -0400
Date: Fri, 15 Aug 2003 16:32:19 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [2.4] [PATCH] update reiserfs docs url in Configure.help
Message-ID: <20030815123219.GA20837@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This trivial patch replaces reiserfs.org url in Configure.help
   with namesys.com, because reiserfs.org was cybersquatted recently.
   Also we do not need any NFS patches anymore.

   Please apply. Thank you.
 

===== Documentation/Configure.help 1.176 vs edited =====
--- 1.176/Documentation/Configure.help	Wed Aug  6 19:21:33 2003
+++ edited/Documentation/Configure.help	Fri Aug  8 19:27:36 2003
@@ -15416,7 +15416,7 @@
 
   In general, ReiserFS is as fast as ext2, but is very efficient with
   large directories and small files.  Additional patches are needed
-  for NFS and quotas, please see <http://www.reiserfs.org/> for links.
+  for quota support, please see <http://www.namesys.com/> for links.
 
   It is more easily extended to have features currently found in
   database and keyword search systems than block allocation based file
@@ -15424,7 +15424,7 @@
   plugins consistent with our motto ``It takes more than a license to
   make source code open.''
 
-  Read <http://www.reiserfs.org/> to learn more about reiserfs.
+  Read <http://www.namesys.com/> to learn more about reiserfs.
 
   Sponsored by Threshold Networks, Emusic.com, and Bigstorage.com.
 
