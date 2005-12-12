Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVLLXLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVLLXLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLLXLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:11:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2308 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932230AbVLLXLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:11:17 -0500
Date: Tue, 13 Dec 2005 00:11:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: lethal@linux-sh.org, kkojima@rr.iij4u.or.jp
Subject: [2.6 patch] MAINTAINERS: sh: remove a subscribers-only list
Message-ID: <20051212231113.GP23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an entry for a subscribers-only list.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-full/MAINTAINERS.old	2005-12-13 00:09:01.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/MAINTAINERS	2005-12-13 00:09:10.000000000 +0100
@@ -2506,11 +2506,10 @@
 SUPERH (sh)
 P:	Paul Mundt
 M:	lethal@linux-sh.org
 P:	Kazumoto Kojima
 M:	kkojima@rr.iij4u.or.jp
-L:	linux-sh@m17n.org
 W:	http://www.linux-sh.org
 W:	http://www.m17n.org/linux-sh/
 W:	http://www.rr.iij4u.or.jp/~kkojima/linux-sh4.html
 S:	Maintained
 


