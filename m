Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbUJ1URi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUJ1URi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUJ1UQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:16:31 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:29596 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262895AbUJ1UGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:06:03 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, james4765@verizon.net
Message-Id: <20041028200601.4340.68983.51463@localhost.localdomain>
In-Reply-To: <20041028200540.4340.4431.73847@localhost.localdomain>
References: <20041028200540.4340.4431.73847@localhost.localdomain>
Subject: [PATCH 3/3] to MAINTAINERS
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 15:06:01 -0500
Date: Thu, 28 Oct 2004 15:06:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Fix reference to digiboard maintenance status - the digiecpa driver
obsoleted the original driver.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/MAINTAINERS linux-2.6.9/MAINTAINERS
--- linux-2.6.9-original/MAINTAINERS	2004-10-18 17:54:37.000000000 -0400
+++ linux-2.6.9/MAINTAINERS	2004-10-28 15:29:59.058211060 -0400
@@ -683,7 +683,7 @@
 M:	christoph@lameter.com
 W:	http://www.digi.com
 L:	digilnux@digi.com
-S:	Orphaned
+S:	Obsolete
 
 DIRECTORY NOTIFICATION
 P:	Stephen Rothwell
