Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbTIHP6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTIHP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:58:21 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:28816 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262511AbTIHP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:58:20 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.0-test4-bk10] fix typo in fs/Kconfig
Date: Mon, 8 Sep 2003 17:59:20 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081759.20794@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't need any comment, does it? ;)

Eike

--- linux-2.6.0-test1/fs/Kconfig	2003-07-14 05:34:42.000000000 +0200
+++ linux-2.6.0-test1-caliban/fs/Kconfig	2003-07-14 16:15:08.000000000 +0200
@@ -1505,7 +1506,7 @@
 	  cifs module since smbfs is currently more stable and provides
 	  support for older servers.  The intent of this module is to provide the
 	  most advanced network file system function for CIFS compliant servers, 
-	  including support for dfs (heirarchical name space), secure per-user
+	  including support for dfs (hierarchical name space), secure per-user
 	  session establishment, safe distributed caching (oplock), optional
 	  packet signing, Unicode and other internationalization improvements, and
 	  optional Winbind (nsswitch) integration.  This module is in an early
