Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVCWXhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVCWXhC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVCWXhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:37:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262101AbVCWXg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:36:58 -0500
Date: Wed, 23 Mar 2005 15:36:51 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, <kas@fi.muni.cz>
Subject: Add myself to MAINTAINERS
Message-ID: <20050323153651.30d78813@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.0.1cvs20.1 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Jan Kasprzak asked a few days ago to have a MAINTAINERS entry for ub.
This patch updates my entries in MAINTAINERS (ub & ymfpci).

Signed-Off-By: Pete Zaitcev <zaitcev@yahoo.com>

--- linux-2.6.12-rc1/MAINTAINERS	2005-03-18 17:11:29.000000000 -0800
+++ linux-2.6.12-rc1-lem/MAINTAINERS	2005-03-21 10:16:56.000000000 -0800
@@ -2313,6 +2313,13 @@ L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
 S:	Maintained
 
+USB BLOCK DRIVER (UB ub)
+P:	Pete Zaitcev
+M:	zaitcev@redhat.com
+L:	linux-kernel@vger.kernel.org
+L:	linux-usb-devel@lists.sourceforge.net
+S:	Supported
+
 USB BLUETOOTH TTY CONVERTER DRIVER
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
@@ -2661,11 +2668,11 @@ M:	jpr@f6fbb.org
 L:	linux-hams@vger.kernel.org
 S:	Maintained
 
-YMFPCI YAMAHA PCI SOUND
+YMFPCI YAMAHA PCI SOUND (Use ALSA instead)
 P:	Pete Zaitcev
 M:	zaitcev@yahoo.com
 L:	linux-kernel@vger.kernel.org
-S:	Maintained
+S:	Obsolete
 
 Z8530 DRIVER FOR AX.25
 P:	Joerg Reuter

