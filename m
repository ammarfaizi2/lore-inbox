Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbULYRIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbULYRIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbULYRIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:08:22 -0500
Received: from coderock.org ([193.77.147.115]:44252 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261527AbULYRIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:08:20 -0500
Date: Sat, 25 Dec 2004 18:08:25 +0100
From: Domen Puncer <domen@coderock.org>
To: rmk@arm.linux.org.uk
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] maintainers: remove moderated arm list
Message-ID: <20041225170825.GA31577@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are subscribed to it, you already know the address. If you are not,
you probably don't want bounces.


Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/MAINTAINERS	2004-12-25 15:50:10.000000000 +0100
+++ a/MAINTAINERS	2004-12-25 18:02:02.000000000 +0100
@@ -296,7 +296,6 @@
 ARM/PT DIGITAL BOARD PORT
 P:	Stefan Eletzhofer
 M:	stefan.eletzhofer@eletztrick.de
-L:	linux-arm-kernel@lists.arm.linux.org.uk
 W:	http://www.arm.linux.org.uk/
 S:	Maintained
 
@@ -309,7 +308,6 @@
 ARM/STRONGARM110 PORT
 P:	Russell King
 M:	rmk@arm.linux.org.uk
-L:	linux-arm-kernel@lists.arm.linux.org.uk
 W:	http://www.arm.linux.org.uk/
 S:	Maintained
 
@@ -1788,7 +1786,6 @@
 PXA2xx SUPPORT
 P:	Nicolas Pitre
 M:	nico@cam.org
-L:	linux-arm-kernel@lists.arm.linux.org.uk
 S:	Maintained
 
 QNX4 FILESYSTEM
