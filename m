Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272577AbTG1AmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272576AbTG1AEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272718AbTG0W6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:14 -0400
Date: Sun, 27 Jul 2003 21:24:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272024.h6RKO2Zp029798@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: maintainer for sk98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/MAINTAINERS linux-2.6.0-test2-ac1/MAINTAINERS
--- linux-2.6.0-test2/MAINTAINERS	2003-07-27 19:56:22.000000000 +0100
+++ linux-2.6.0-test2-ac1/MAINTAINERS	2003-07-27 19:59:03.000000000 +0100
@@ -1174,6 +1174,14 @@
 W:	http://www.tazenda.demon.co.uk/phil/linux-hp
 S:	Maintained
 
+MARVELL YUKON / SYSKONNECT DRIVER
+P:	Mirko Lindner
+M: 	mlindner@syskonnect.de
+P:	Ralph Roesler
+M: 	rroesler@syskonnect.de
+W: 	http://www.syskonnect.com
+S: 	Supported
+
 MAESTRO PCI SOUND DRIVERS
 P:	Zach Brown
 M:	zab@zabbo.net
