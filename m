Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUJZUGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUJZUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUJZUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:05:34 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:17628 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261463AbUJZUDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:03:31 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: james4765@verizon.net
Message-Id: <20041026200326.24275.4567.94175@localhost.localdomain>
In-Reply-To: <20041026200320.24275.17430.77560@localhost.localdomain>
References: <20041026200320.24275.17430.77560@localhost.localdomain>
Subject: [patch 1/2] ftape update
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.211.53] at Tue, 26 Oct 2004 15:03:26 -0500
Date: Tue, 26 Oct 2004 15:03:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After tracking down the original author of the ftape sources, I found out
that he no longer had interest in maintaining it.  Apply against 2.6.9.

Purpose: Update status of ftape project in MAINTAINERS.

Signed-off-by: James Nelson <james4765@gmail.com>

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
