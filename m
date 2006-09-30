Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWI3Ioa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWI3Ioa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWI3IoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:44:04 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:54439 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751158AbWI3Inw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:43:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 4] x86-64: Calgary IOMMU: Update Jon's contact info
X-Mercurial-Node: 7aff757cee0ea0566ae4016b43a0284769b0b27a
Message-Id: <7aff757cee0ea0566ae4.1159605811@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1159605808@rhun.haifa.ibm.com>
Date: Sat, 30 Sep 2006 11:43:31 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 files changed, 3 insertions(+), 2 deletions(-)
MAINTAINERS                      |    2 +-
arch/x86_64/kernel/pci-calgary.c |    3 ++-


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1159604379 -10800
# Node ID 7aff757cee0ea0566ae4016b43a0284769b0b27a
# Parent  e0562474cf16b13d8c3c815fce3159ba7cd0f540
x86-64: Calgary IOMMU: Update Jon's contact info

From: Jon Mason <jdmason@kudzu.us>

Also add copyright for work done after leaving IBM.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r e0562474cf16 -r 7aff757cee0e MAINTAINERS
--- a/MAINTAINERS	Sat Sep 30 11:18:31 2006 +0300
+++ b/MAINTAINERS	Sat Sep 30 11:19:39 2006 +0300
@@ -643,7 +643,7 @@ P:	Muli Ben-Yehuda
 P:	Muli Ben-Yehuda
 M:	muli@il.ibm.com
 P:	Jon D. Mason
-M:	jdmason@us.ibm.com
+M:	jdmason@kudzu.us
 L:	linux-kernel@vger.kernel.org
 L:	discuss@x86-64.org
 S:	Maintained
diff -r e0562474cf16 -r 7aff757cee0e arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:18:31 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:19:39 2006 +0300
@@ -2,8 +2,9 @@
  * Derived from arch/powerpc/kernel/iommu.c
  *
  * Copyright (C) IBM Corporation, 2006
+ * Copyright (C) 2006  Jon Mason <jdmason@kudzu.us>
  *
- * Author: Jon Mason <jdmason@us.ibm.com>
+ * Author: Jon Mason <jdmason@kudzu.us>
  * Author: Muli Ben-Yehuda <muli@il.ibm.com>
 
  * This program is free software; you can redistribute it and/or modify
