Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbUJ3B6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbUJ3B6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUJ3ByP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:54:15 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:54224 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S263462AbUJ3Bn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:43:28 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041030014323.12427.23460.52196@localhost.localdomain>
In-Reply-To: <20041030014310.12427.89090.67655@localhost.localdomain>
References: <20041030014310.12427.89090.67655@localhost.localdomain>
Subject: [PATCH 2/2] computone: MAINTAINERS update
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.211.53] at Fri, 29 Oct 2004 20:43:23 -0500
Date: Fri, 29 Oct 2004 20:43:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: update status of Computone Intelliport driver in MAINTAINERS.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/MAINTAINERS linux-2.6.9/MAINTAINERS
--- linux-2.6.9-original/MAINTAINERS	2004-10-18 17:54:37.000000000 -0400
+++ linux-2.6.9/MAINTAINERS	2004-10-29 20:44:19.844465685 -0400
@@ -531,10 +531,9 @@
 COMPUTONE INTELLIPORT MULTIPORT CARD
 P:	Michael H. Warfield
 M:	Michael H. Warfield <mhw@wittsend.com>
-W:	http://www.computone.com/
 W:	http://www.wittsend.com/computone.html
 L:	linux-computone@lazuli.wittsend.com
-S:	Supported
+S:	Orphaned
 
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak
