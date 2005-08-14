Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVHNPIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVHNPIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVHNPIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:08:53 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:49415 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932544AbVHNPIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:08:52 -0400
Date: Sun, 14 Aug 2005 17:09:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] (2/5) I2C updates for 2.4.32-pre3
Message-Id: <20050814170933.621807ba.khali@linux-fr.org>
In-Reply-To: <20050814151320.76e906d5.khali@linux-fr.org>
References: <20050814151320.76e906d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lm_sensors project changed mailing lists.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 MAINTAINERS |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.30.orig/MAINTAINERS	2005-06-03 19:21:41.000000000 +0200
+++ linux-2.4.30/MAINTAINERS	2005-06-03 19:23:35.000000000 +0200
@@ -820,7 +820,7 @@
 I2C SUBSYSTEM
 P:	Jean Delvare
 M:	khali@linux-fr.org
-L:	sensors@stimpy.netroedge.com
+L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.nu/
 S:	Maintained
 

-- 
Jean Delvare
