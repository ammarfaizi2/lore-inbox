Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263114AbVCDWRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbVCDWRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbVCDWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:15:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:42145 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263133AbVCDUyT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:19 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Change of i2c co-maintainer
In-Reply-To: <11099685971064@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <1109968597146@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2115, 2005/03/02 16:13:14-08:00, khali@linux-fr.org

[PATCH] I2C: Change of i2c co-maintainer

Since I am working more actively than Philip (or anyone else, for that
matter) on the i2c subsystem these days, it would probably make sense
that I am listed as the co-maintainer instead of him.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Philip Edelbrock <phil@netroedge.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-03-04 12:22:45 -08:00
+++ b/MAINTAINERS	2005-03-04 12:22:45 -08:00
@@ -991,8 +991,8 @@
 I2C AND SENSORS DRIVERS
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
-P:	Philip Edelbrock
-M:	phil@netroedge.com
+P:	Jean Delvare
+M:	khali@linux-fr.org
 L:	sensors@stimpy.netroedge.com
 W:	http://www.lm-sensors.nu/
 S:	Maintained

