Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbTLRUPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265324AbTLRUPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:15:30 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:33074 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265321AbTLRUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:15:29 -0500
Date: Thu, 18 Dec 2003 12:15:19 -0800
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] update sn2 MAINTAINERS file entry
Message-ID: <20031218201519.GA32645@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick patch to fix MAINTAINERS for sn2.

Jesse

diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Mon Nov 24 12:40:35 2003
+++ b/MAINTAINERS	Mon Nov 24 12:40:35 2003
@@ -929,8 +929,9 @@
 S:	Maintained
 
 SN-IA64 (Itanium) SUB-PLATFORM
-P:	John Hesterberg
-M:	jh@sgi.com
+P:	Jesse Barnes
+M:	jbarnes@sgi.com
+L:	linux-altix@sgi.com
 L:	linux-ia64@linuxia64.org
 W:	http://www.sgi.com/altix
 S:	Maintained
