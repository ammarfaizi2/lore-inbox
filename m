Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272389AbTG1ACW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272343AbTG1AB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:57 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272924AbTG0XBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:30 -0400
Date: Sun, 27 Jul 2003 21:00:40 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272000.h6RK0e4j029563@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: kill an old __NO_VERSION__
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Adrian Bunk(
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/drm/gamma_lists.h linux-2.6.0-test2-ac1/drivers/char/drm/gamma_lists.h
--- linux-2.6.0-test2/drivers/char/drm/gamma_lists.h	2003-07-10 21:06:12.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/drm/gamma_lists.h	2003-07-23 15:44:21.000000000 +0100
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 
