Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVACRJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVACRJC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVACRJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:09:02 -0500
Received: from coderock.org ([193.77.147.115]:50070 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261502AbVACRIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:08:50 -0500
Date: Mon, 3 Jan 2005 18:08:49 +0100
From: Domen Puncer <domen@coderock.org>
To: rmk@arm.linux.org.uk
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] maintainers: mark linux-arm-kernel as subscription only
Message-ID: <20050103170849.GB5965@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark linux-arm-kernel@lists.arm.linux.org.uk as subscription only.


Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/MAINTAINERS	2005-01-03 17:58:46.000000000 +0100
+++ a/MAINTAINERS	2005-01-03 18:00:28.000000000 +0100
@@ -296,7 +296,7 @@
 ARM/PT DIGITAL BOARD PORT
 P:	Stefan Eletzhofer
 M:	stefan.eletzhofer@eletztrick.de
-L:	linux-arm-kernel@lists.arm.linux.org.uk
+L:	linux-arm-kernel@lists.arm.linux.org.uk (subscription required)
 W:	http://www.arm.linux.org.uk/
 S:	Maintained
 
@@ -309,7 +309,7 @@
 ARM/STRONGARM110 PORT
 P:	Russell King
 M:	rmk@arm.linux.org.uk
-L:	linux-arm-kernel@lists.arm.linux.org.uk
+L:	linux-arm-kernel@lists.arm.linux.org.uk (subscription required)
 W:	http://www.arm.linux.org.uk/
 S:	Maintained
 
@@ -1798,7 +1798,7 @@
 PXA2xx SUPPORT
 P:	Nicolas Pitre
 M:	nico@cam.org
-L:	linux-arm-kernel@lists.arm.linux.org.uk
+L:	linux-arm-kernel@lists.arm.linux.org.uk (subscription required)
 S:	Maintained
 
 QNX4 FILESYSTEM
