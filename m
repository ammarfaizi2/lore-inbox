Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWGAKyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWGAKyD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWGAKyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:54:01 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24601 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750799AbWGAKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:54:00 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] Fix Calgary copyright statements per IBM guidelines
X-Mercurial-Node: c4bd0cdcce626b9edc0b4fa3e94c8d9666cf977a
Message-Id: <c4bd0cdcce626b9edc0b.1151751237@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1151751236@rhun.haifa.ibm.com>
Date: Sat,  1 Jul 2006 13:53:57 +0300
From: muli@il.ibm.com
To: ak@suse.de
Cc: muli@il.ibm.com, jdmason@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Node ID c4bd0cdcce626b9edc0b4fa3e94c8d9666cf977a
# Parent  c77454706594f66e8751656a28223db4aaef8a11
Fix Calgary copyright statements per IBM guidelines

Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-Off-By: Jon Mason <jdmason@us.ibm.com>

diff -r c77454706594 -r c4bd0cdcce62 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Sat Jul 01 13:36:55 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Sat Jul 01 13:39:52 2006 +0300
@@ -1,9 +1,11 @@
 /*
  * Derived from arch/powerpc/kernel/iommu.c
  *
- * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
- * Copyright (C) 2006 Muli Ben-Yehuda <muli@il.ibm.com>, IBM Corporation
+ * Copyright (C) IBM Corporation, 2006
  *
+ * Author: Jon Mason <jdmason@us.ibm.com>
+ * Author: Muli Ben-Yehuda <muli@il.ibm.com>
+
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
diff -r c77454706594 -r c4bd0cdcce62 arch/x86_64/kernel/tce.c
--- a/arch/x86_64/kernel/tce.c	Sat Jul 01 13:36:55 2006 +0300
+++ b/arch/x86_64/kernel/tce.c	Sat Jul 01 13:39:52 2006 +0300
@@ -1,8 +1,10 @@
 /*
  * Derived from arch/powerpc/platforms/pseries/iommu.c
  *
- * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
- * Copyright (C) 2006 Muli Ben-Yehuda <muli@il.ibm.com>, IBM Corporation
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Jon Mason <jdmason@us.ibm.com>
+ * Author: Muli Ben-Yehuda <muli@il.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff -r c77454706594 -r c4bd0cdcce62 include/asm-x86_64/calgary.h
--- a/include/asm-x86_64/calgary.h	Sat Jul 01 13:36:55 2006 +0300
+++ b/include/asm-x86_64/calgary.h	Sat Jul 01 13:39:52 2006 +0300
@@ -1,8 +1,10 @@
 /*
  * Derived from include/asm-powerpc/iommu.h
  *
- * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
- * Copyright (C) 2006 Muli Ben-Yehuda <muli@il.ibm.com>, IBM Corporation
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Jon Mason <jdmason@us.ibm.com>
+ * Author: Muli Ben-Yehuda <muli@il.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff -r c77454706594 -r c4bd0cdcce62 include/asm-x86_64/tce.h
--- a/include/asm-x86_64/tce.h	Sat Jul 01 13:36:55 2006 +0300
+++ b/include/asm-x86_64/tce.h	Sat Jul 01 13:39:52 2006 +0300
@@ -1,8 +1,10 @@
 /*
- * Copyright (C) 2006 Muli Ben-Yehuda <muli@il.ibm.com>, IBM Corporation
- * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
+ * This file is derived from asm-powerpc/tce.h.
  *
- * This file is derived from asm-powerpc/tce.h.
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Muli Ben-Yehuda <muli@il.ibm.com>
+ * Author: Jon Mason <jdmason@us.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
