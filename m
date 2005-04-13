Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVDMXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDMXTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDMXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:19:33 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:35248 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S261222AbVDMXTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:19:31 -0400
Date: Thu, 14 Apr 2005 01:21:39 +0200
From: Daniel Andersen <daniel@linux-user.net>
Subject: [PATCH][TRIVIAL][DOCUMENTATION] - Version clarification - support
 status of 3com OfficeConnect card
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Message-id: <425DA983.1010607@linux-user.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of the 3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72 is
not supported by the prism54 project. To stop confusion, the kernel
documentation should state so as 3com made a good job hiding the version
difference.

Daniel Andersen
-- 

--- linux/drivers/net/wireless/Kconfig.orig    2005-04-14 
00:55:45.000000000 +0200
+++ linux/drivers/net/wireless/Kconfig    2005-04-14 00:56:14.000000000 
+0200
@@ -323,7 +323,7 @@ config PRISM54
       For a complete list of supported cards visit <http://prism54.org>.
       Here is the latest confirmed list of supported cards:

-      3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72
+      3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72 (version 1)
       Allnet ALL0271 PCI Card
       Compex WL54G Cardbus Card
       Corega CG-WLCB54GT Cardbus Card
