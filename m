Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVA0Xun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVA0Xun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVA0Xuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:50:39 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:22230 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261296AbVA0XbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:31:03 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, cristoph@lameter.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050127233100.23569.81289.91357@localhost.localdomain>
In-Reply-To: <20050127233053.23569.16444.60993@localhost.localdomain>
References: <20050127233053.23569.16444.60993@localhost.localdomain>
Subject: [PATCH 1/8] pcxx: Remove reference in MAINTAINERS
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 17:31:00 -0600
Date: Thu, 27 Jan 2005 17:31:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes references to the pcxx driver in MAINTAINERS.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc2-mm1-original/MAINTAINERS linux-2.6.11-rc2-mm1/MAINTAINERS
--- linux-2.6.11-rc2-mm1-original/MAINTAINERS	2005-01-24 17:16:10.000000000 -0500
+++ linux-2.6.11-rc2-mm1/MAINTAINERS	2005-01-27 16:51:18.000000000 -0500
@@ -708,13 +708,6 @@
 W:	http://www.digi.com
 S:	Orphaned
 
-DIGIBOARD PC/XE AND PC/XI DRIVER
-P:	Christoph Lameter
-M:	christoph@lameter.com
-W:	http://www.digi.com
-L:	digilnux@digi.com
-S:	Obsolete
-
 DIRECTORY NOTIFICATION
 P:	Stephen Rothwell
 M:	sfr@canb.auug.org.au
