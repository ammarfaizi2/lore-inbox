Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVIVHss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVIVHss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVIVHsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:48:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:37298 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751436AbVIVHsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:16 -0400
Date: Thu, 22 Sep 2005 00:47:46 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 04/18] I2C: remove me from the MAINTAINERS file for i2c
Message-ID: <20050922074746.GE15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i2c-maintainer.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove my name from the I2C maintainer, Jean is more than capable of
handling it all now.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>


---
 MAINTAINERS |    2 --
 1 file changed, 2 deletions(-)

--- scsi-2.6.orig/MAINTAINERS	2005-09-20 05:59:35.000000000 -0700
+++ scsi-2.6/MAINTAINERS	2005-09-21 17:29:25.000000000 -0700
@@ -1063,8 +1063,6 @@
 S:	Maintained
 
 I2C SUBSYSTEM
-P:	Greg Kroah-Hartman
-M:	greg@kroah.com
 P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org

--
