Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbRAUDlx>; Sat, 20 Jan 2001 22:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130633AbRAUDlm>; Sat, 20 Jan 2001 22:41:42 -0500
Received: from hromeo.algonet.se ([194.213.74.51]:52395 "HELO
	hromeo.algonet.se") by vger.kernel.org with SMTP id <S130105AbRAUDlg>;
	Sat, 20 Jan 2001 22:41:36 -0500
Date: Sun, 21 Jan 2001 04:41:05 +0100
From: André Dahlqvist <anedah-9@sm.luth.se>
To: axel@uni-paderborn.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update URL for hdparm in Configure.help
Message-ID: <20010121044105.A2143@sm.luth.se>
Mail-Followup-To: axel@uni-paderborn.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch changes the URL of hdparm to one which actually
has the newest version of that tool. The patch is against 2.4.1-pre9.

--- linux/Documentation/Configure.help~	Sun Jan 21 04:08:54 2001
+++ linux/Documentation/Configure.help	Sun Jan 21 04:19:09 2001
@@ -415,7 +415,7 @@
 
   To fine-tune ATA/IDE drive/interface parameters for improved
   performance, look for the hdparm package at
-  ftp://metalab.unc.edu/pub/Linux/kernel/patches/diskdrives/ .
+  http://www.ibiblio.org/pub/Linux/system/hardware .
 
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
-- 

André Dahlqvist <anedah-9@sm.luth.se>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
