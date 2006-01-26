Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWAZMKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWAZMKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWAZMKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:10:24 -0500
Received: from ash25e.internode.on.net ([203.16.214.182]:7950 "EHLO
	ash25e.internode.on.net") by vger.kernel.org with ESMTP
	id S1751332AbWAZMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:10:23 -0500
From: James Ring <sjr@jdns.org>
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [PATCH][TRIVIAL] Fix spelling in E1000_DISABLE_PACKET_SPLIT Kconfig description
Date: Thu, 26 Jan 2006 23:10:02 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 698
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601262310.09126.sjr@jdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just something I noticed when building 2.6.16-rc1.

Thank you!

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 626508a..616f61a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1920,7 +1920,7 @@ config E1000_DISABLE_PACKET_SPLIT
 	depends on E1000
 	help
 	  Say Y here if you want to use the legacy receive path for PCI express
-	  hadware.
+	  hardware.
 
 	  If in doubt, say N.
 

-- 
James Ring
