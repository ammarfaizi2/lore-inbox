Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWGZR73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWGZR73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWGZR73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:59:29 -0400
Received: from mga03.intel.com ([143.182.124.21]:61716 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751099AbWGZR72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:59:28 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105096833:sNHT1944888141"
Date: Wed, 26 Jul 2006 10:59:25 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [patch] add Dock Station driver to MAINTAINERS
Message-Id: <20060726105925.221718c4.kristen.c.accardi@intel.com>
In-Reply-To: <20060726105233.b31b5135.kristen.c.accardi@intel.com>
References: <20060726105233.b31b5135.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Dock driver to the MAINTAINERS file

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- 2.6-git.orig/MAINTAINERS
+++ 2.6-git/MAINTAINERS
@@ -882,6 +882,12 @@ M:	rdunlap@xenotime.net
 T:	git http://tali.admingilde.org/git/linux-docbook.git
 S:	Maintained
 
+DOCKING STATION DRIVER
+P:	Kristen Carlson Accardi
+M:	kristen.c.accardi@intel.com
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+
 DOUBLETALK DRIVER
 P:	James R. Van Zandt
 M:	jrv@vanzandt.mv.com
