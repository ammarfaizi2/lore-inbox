Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWEOO2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWEOO2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEOO2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:28:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60892 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964843AbWEOO2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:28:32 -0400
Date: Mon, 15 May 2006 10:28:05 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Kdump maintainer info update
Message-ID: <20060515142805.GA6517@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew mentioned that it is confusing who is maintaining kdump and some
update to MAINTAINERS regarding kdump is required.

o Updating MAINTAINERS file for info regarding kdump maintainership.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-rc4-1M-vivek/MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -puN MAINTAINERS~kdump-maintainers-update MAINTAINERS
--- linux-2.6.17-rc4-1M/MAINTAINERS~kdump-maintainers-update	2006-05-15 10:05:45.000000000 -0400
+++ linux-2.6.17-rc4-1M-vivek/MAINTAINERS	2006-05-15 10:21:20.000000000 -0400
@@ -1536,6 +1536,16 @@ M:	zippel@linux-m68k.org
 L:	kbuild-devel@lists.sourceforge.net
 S:	Maintained
 
+KDUMP
+P:	Vivek Goyal
+M:	vgoyal@in.ibm.com
+P:	Haren Myneni
+M:	hbabu@us.ibm.com
+L:	fastboot@lists.osdl.org
+L:	linux-kernel@vger.kernel.org
+W:	http://lse.sourceforge.net/kdump/
+S:	Maintained
+
 KERNEL AUTOMOUNTER (AUTOFS)
 P:	H. Peter Anvin
 M:	hpa@zytor.com
_
