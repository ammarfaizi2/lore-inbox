Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTIMAXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbTIMAXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:23:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:44518 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261974AbTIMAXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:23:15 -0400
Date: Fri, 12 Sep 2003 17:23:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil
Subject: [PATCH 2/4] 2.6.0-test5-bk Add LSM maintainer entry
Message-ID: <20030912172312.B8718@build.pdx.osdl.net>
References: <20030912171833.A8718@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030912171833.A8718@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Sep 12, 2003 at 05:18:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Add LSM maintainer entry

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+)

--- 2.6.0-test5-bk/MAINTAINERS.maint	Wed Sep  3 23:39:56 2003
+++ 2.6.0-test5-bk/MAINTAINERS	Fri Sep 12 15:41:12 2003
@@ -1159,6 +1159,13 @@
 L:	linuxppc64-dev@lists.linuxppc.org
 S:	Supported
 
+LINUX SECURITY MODULE (LSM) FRAMEWORK
+P:	Chris Wright
+M:	chrisw@osdl.org
+L:	linux-security-module@wirex.com
+W:	http://lsm.immunix.org
+S:	Supported
+
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP Dynamic Disks)
 P:	Richard Russon (FlatCap)
 M:	ldm@flatcap.org
