Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUJXUiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUJXUiA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJXUiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:38:00 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:52650 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261625AbUJXUhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:37:55 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: james4765@verizon.net
Message-Id: <20041024203754.13780.1905.60919@localhost.localdomain>
In-Reply-To: <20041024203748.13780.86066.84472@localhost.localdomain>
References: <20041024203748.13780.86066.84472@localhost.localdomain>
Subject: [patch 1/2] ftape update
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Sun, 24 Oct 2004 15:37:54 -0500
Date: Sun, 24 Oct 2004 15:37:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After tracking down the original author of the ftape sources, I found out
that he no longer had interest in maintaining it.

Purpose: Update status of ftape project in MAINTAINERS.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u --exclude='*~' linux-2.6.9-original/MAINTAINERS linux-2.6.9/MAINTAINERS
--- linux-2.6.9-original/MAINTAINERS	2004-10-18 17:54:37.000000000 -0400
+++ linux-2.6.9/MAINTAINERS	2004-10-24 09:49:51.376708662 -0400
@@ -858,11 +858,9 @@
 S:	Maintained
 
 FTAPE/QIC-117
-P:	Claus-Justus Heine
-M:	claus@momo.math.rwth-aachen.de
 L:	linux-tape@vger.kernel.org
-W:	http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape/
-S:	Maintained
+W:	http://sourceforge.net/projects/ftape
+S:	Orphan
 
 FUTURE DOMAIN TMC-16x0 SCSI DRIVER (16-bit)
 P:	Rik Faith
