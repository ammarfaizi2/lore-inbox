Return-Path: <linux-kernel-owner+w=401wt.eu-S964795AbXAJIeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbXAJIeL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbXAJIeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:34:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:37885 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798AbXAJIeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:34:10 -0500
Date: Wed, 10 Jan 2007 09:33:53 +0100 (MET)
Message-Id: <200701100833.l0A8XrY6017424@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.20-rc4] MAINTAINERS: maintainer for sata_promise
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds myself as maintainer of the sata_promise
libata driver.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.20-rc4/MAINTAINERS.~1~	2007-01-08 20:42:55.000000000 +0100
+++ linux-2.6.20-rc4/MAINTAINERS	2007-01-10 01:04:23.000000000 +0100
@@ -2622,6 +2622,12 @@ M:	promise@pnd-pc.demon.co.uk
 W:	http://www.pnd-pc.demon.co.uk/promise/
 S:	Maintained
 
+PROMISE SATA TX2/TX4 CONTROLLER LIBATA DRIVER
+P:	Mikael Pettersson
+M:	mikpe@it.uu.se
+L:	linux-ide@vger.kernel.org
+S:	Maintained
+
 PS3 PLATFORM SUPPORT
 P:	Geoff Levand
 M:	geoffrey.levand@am.sony.com
