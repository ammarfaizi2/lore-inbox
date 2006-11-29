Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967638AbWK2U0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967638AbWK2U0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967639AbWK2U0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:26:54 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:55818 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S967638AbWK2U0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:26:54 -0500
Date: Wed, 29 Nov 2006 21:26:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] MAINTAINERS: Update the i2c and hwmon subsystems info
Message-Id: <20061129212655.e8dc3c2d.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c and hwmon trees have moved to a new location.

The lm-sensors project moved to a new home as well.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc6.orig/MAINTAINERS	2006-11-27 10:55:11.000000000 +0100
+++ linux-2.6.19-rc6/MAINTAINERS	2006-11-29 21:18:59.000000000 +0100
@@ -1212,7 +1212,8 @@
 P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
-W:	http://www.lm-sensors.nu/
+W:	http://www.lm-sensors.org/
+T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
 S:	Maintained
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
@@ -1338,8 +1339,7 @@
 P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	i2c@lm-sensors.org
-W:	http://www.lm-sensors.nu/
-T:	quilt kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
+T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
 S:	Maintained
 
 I2O


-- 
Jean Delvare
