Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267796AbTBRMVS>; Tue, 18 Feb 2003 07:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267797AbTBRMVS>; Tue, 18 Feb 2003 07:21:18 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:54468 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S267796AbTBRMVR>; Tue, 18 Feb 2003 07:21:17 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.62] Typo in Makefile
Date: Tue, 18 Feb 2003 13:32:37 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302181332.37143@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus asked for typo fixes, so here is one...

Eike

diff -Naur linux-2.5.62/Makefile linux-2.5.62-eike/Makefile
--- linux-2.5.62/Makefile	Mon Feb 17 23:55:54 2003
+++ linux-2.5.62-eike/Makefile	Tue Feb 18 13:25:41 2003
@@ -580,7 +580,7 @@
 	. scripts/mkspec >kernel.spec
 
 #	Build a tar ball, generate an rpm from it and pack the result
-#	There arw two bits of magic here
+#	There are two bits of magic here
 #	1) The use of /. to avoid tar packing just the symlink
 #	2) Removing the .dep files as they have source paths in them that
 #	   will become invalid
