Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSDJPAQ>; Wed, 10 Apr 2002 11:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSDJPAP>; Wed, 10 Apr 2002 11:00:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:5136 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S313187AbSDJPAM>;
	Wed, 10 Apr 2002 11:00:12 -0400
Message-ID: <3CB45265.3000500@namesys.com>
Date: Wed, 10 Apr 2002 18:55:33 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bugfixes 9 of 13, please apply
Content-Type: multipart/mixed;
 boundary="------------010605010907060601050101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010605010907060601050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010605010907060601050101
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 9 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 9 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13270 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 0E103354ACF; Wed, 10 Apr 2002 15:21:51 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:51 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 9 of 13
Message-ID: <20020410152151.A20901@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch is to change comment of CONFIG_REISERFS_PROC_INFO config item,
to make it more clear.

===== Config.help 1.4 vs 1.5 =====
--- 1.4/fs/Config.help	Mon Feb 25 12:31:17 2002
+++ 1.5/fs/Config.help	Thu Mar 28 15:45:04 2002
@@ -59,12 +59,12 @@
   everyone should say N.
 
 CONFIG_REISERFS_PROC_INFO
-  Create under /proc/fs/reiserfs hierarchy of files, displaying
-  various ReiserFS statistics and internal data on the expense of
-  making your kernel or module slightly larger (+8 KB).  This also
-  increases amount of kernel memory required for each mount.  Almost
-  everyone but ReiserFS developers and people fine-tuning reiserfs or
-  tracing problems should say N.
+  Create under /proc/fs/reiserfs a hierarchy of files, displaying
+  various ReiserFS statistics and internal data at the expense of
+  making your kernel or module slightly larger (+8 KB). This also
+  increases the amount of kernel memory required for each mount.
+  Almost everyone but ReiserFS developers and people fine-tuning
+  reiserfs or tracing problems should say N.
 
 CONFIG_EXT2_FS
   This is the de facto standard Linux file system (method to organize



--------------010605010907060601050101--

