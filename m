Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276599AbRI2ToV>; Sat, 29 Sep 2001 15:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276601AbRI2ToM>; Sat, 29 Sep 2001 15:44:12 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:11026 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276599AbRI2Tny>;
	Sat, 29 Sep 2001 15:43:54 -0400
Message-ID: <3BB624D9.4080705@si.rr.com>
Date: Sat, 29 Sep 2001 15:45:29 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.9-ac17: jffs and jffs2 MODULE_LICENSE
Content-Type: multipart/mixed;
 boundary="------------030109020100020604030904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109020100020604030904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
     The attached files add the MODULE_LICENSE statement to the jffs and 
jffs2.
Regards,
Frank

--------------030109020100020604030904
Content-Type: text/plain;
 name="JFFS_MOD"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="JFFS_MOD"

--- fs/jffs/inode-v23.c.old	Fri Sep 28 21:21:39 2001
+++ fs/jffs/inode-v23.c	Sat Sep 29 15:18:22 2001
@@ -1749,3 +1749,4 @@
 
 module_init(init_jffs_fs)
 module_exit(exit_jffs_fs)
+MODULE_LICENSE("GPL");

--------------030109020100020604030904
Content-Type: text/plain;
 name="JFFS2_MO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="JFFS2_MO"

--- fs/jffs2/super.c.old	Fri Sep 28 21:21:40 2001
+++ fs/jffs2/super.c	Sat Sep 29 15:26:26 2001
@@ -353,3 +353,4 @@
 
 module_init(init_jffs2_fs);
 module_exit(exit_jffs2_fs);
+MODULE_LICENSE("GPL"); // Also uses the RHEPL

--------------030109020100020604030904--

