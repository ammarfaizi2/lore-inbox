Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264385AbUEMScT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbUEMScT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUEMScS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:32:18 -0400
Received: from village.ehouse.ru ([193.111.92.18]:784 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264385AbUEMScK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:32:10 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] befs (4/5): typo fix
Date: Thu, 13 May 2004 22:20:43 +0400
User-Agent: KMail/1.6.1
Cc: Will Dyson <will_dyson@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <E1BOL04-0003ou-01@mail.ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix really old typo in config help

===== fs/Kconfig 1.55 vs edited =====
--- 1.55/fs/Kconfig	Mon May 10 15:25:57 2004
+++ edited/fs/Kconfig	Thu May 13 20:17:22 2004
@@ -1025,7 +1025,7 @@
 	  style features such as file ownership and permissions.
 
 config BEFS_FS
-	tristate "BeOS file systemv(BeFS) support (read only) (EXPERIMENTAL)"
+	tristate "BeOS file system (BeFS) support (read only) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select NLS
 	help

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

