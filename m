Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTJMKi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTJMKi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:38:59 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:47315 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261644AbTJMKiz
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 13 Oct 2003 06:38:55 -0400
Message-ID: <3F8A7FC0.2090605@namesys.com>
Date: Mon, 13 Oct 2003 14:34:40 +0400
From: Yury Umanets <umka@namesys.com>
Organization: NAMESYS.COM
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030917
X-Accept-Language: en-us, ru, uk
MIME-Version: 1.0
To: Linux-Kernel@Vger.Kernel.ORG
CC: Torvalds@Osdl.COM, AKPM@Osdl.ORG, Hans Reiser <reiser@namesys.com>
Subject: reiserfs documentation patch...
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This is reiserfs Kconfig patch. It fixes link to NAMESYS website.

Linus, please apply this.

--
umka

===== fs/Kconfig 1.38 vs edited =====
--- 1.38/fs/Kconfig     Wed Oct  8 20:12:03 2003
+++ edited/fs/Kconfig   Fri Oct 10 14:26:19 2003
@@ -204,7 +204,7 @@
 
          In general, ReiserFS is as fast as ext2, but is very efficient 
with
          large directories and small files.  Additional patches are needed
-         for NFS and quotas, please see <http://www.reiserfs.org/> for 
links.
+         for NFS and quotas, please see <http://www.namesys.com/> for 
links.
 
          It is more easily extended to have features currently found in
          database and keyword search systems than block allocation 
based file
@@ -212,7 +212,7 @@
          plugins consistent with our motto ``It takes more than a 
license to
          make source code open.''
 
-         Read <http://www.reiserfs.org/> to learn more about reiserfs.
+         Read <http://www.namesys.com/> to learn more about reiserfs.
 
          Sponsored by Threshold Networks, Emusic.com, and Bigstorage.com.
 


