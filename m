Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWALWP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWALWP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161364AbWALWP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:15:26 -0500
Received: from mxout4.cac.washington.edu ([140.142.33.19]:60583 "EHLO
	mxout4.cac.washington.edu") by vger.kernel.org with ESMTP
	id S1161361AbWALWPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:15:25 -0500
X-Auth-Received: from athena.sea.amer.gettywan.com (outbound.gettyimages.com [206.28.72.1])
	(authenticated authid=ashepard)
	by smtp.washington.edu (8.13.5+UW05.10/8.13.5+UW05.09) with ESMTP id k0CMFHg8028240
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Thu, 12 Jan 2006 14:15:20 -0800
Subject: [PATCH] Spelling fix in IPW2100 and IPW2200 Kconfig entries
From: Alex Shepard <ashepard@u.washington.edu>
To: jketreno@linux.intel.com, yi.zhu@intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain
Date: Thu, 12 Jan 2006 14:15:13 -0800
Message-Id: <1137104113.15772.17.camel@athena>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Uwash-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/remvoed/removed/


Signed-off-by: Alex Shepard <ashepard@u.washington.edu>

--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -160,7 +160,7 @@ config IPW2100
           <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
  
           If you want to compile the driver as a module ( = code which can be
-          inserted in and remvoed from the running kernel whenever you want),
+          inserted in and removed from the running kernel whenever you want),
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2100.ko.
 	
@@ -213,7 +213,7 @@ config IPW2200
           <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
  
           If you want to compile the driver as a module ( = code which can be
-          inserted in and remvoed from the running kernel whenever you want),
+          inserted in and removed from the running kernel whenever you want),
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2200.ko.
 


