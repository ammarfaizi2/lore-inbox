Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVCBSug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVCBSug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCBSug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:50:36 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:64266 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262322AbVCBSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:50:30 -0500
Date: Wed, 2 Mar 2005 19:51:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Philip Edelbrock <phil@netroedge.com>
Subject: [PATCH 2.6] Change of i2c co-maintainer
Message-Id: <20050302195106.4bf0b1ec.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

Since I am working more actively than Philip (or anyone else, for that
matter) on the i2c subsystem these days, it would probably make sense
that I am listed as the co-maintainer instead of him.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc5/MAINTAINERS.orig	2005-02-25 20:25:45.000000000 +0100
+++ linux-2.6.11-rc5/MAINTAINERS	2005-03-02 19:50:04.000000000 +0100
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


-- 
Jean Delvare
