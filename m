Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbULLNLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbULLNLo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 08:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbULLNLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 08:11:44 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:39313 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262061AbULLNLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 08:11:43 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041212131204.10593.730.45603@localhost.localdomain>
Subject: [PATCH] specialix: remove bouncing e-mail address
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Sun, 12 Dec 2004 07:11:42 -0600
Date: Sun, 12 Dec 2004 07:11:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-original/MAINTAINERS linux-2.6.10-rc3/MAINTAINERS
--- linux-2.6.10-rc3-original/MAINTAINERS	2004-12-03 16:53:57.000000000 -0500
+++ linux-2.6.10-rc3/MAINTAINERS	2004-12-12 08:05:03.612339187 -0500
@@ -2047,7 +2047,6 @@
 SPECIALIX IO8+ MULTIPORT SERIAL CARD DRIVER
 P:	Roger Wolff
 M:	R.E.Wolff@BitWizard.nl
-M:	io8-linux@specialix.co.uk
 L:	linux-kernel@vger.kernel.org ?
 S:	Supported
 
