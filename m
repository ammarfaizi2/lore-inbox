Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSLCNRn>; Tue, 3 Dec 2002 08:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSLCNRn>; Tue, 3 Dec 2002 08:17:43 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:30380 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261433AbSLCNRm>; Tue, 3 Dec 2002 08:17:42 -0500
Date: Tue, 3 Dec 2002 14:25:08 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (x86-64)
Message-ID: <20021203132508.GL2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused CONFIG_UDF_RW from x86-64 defconfig

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/x86_64/defconfig linux-2.5.50-eaa/arch/x86_64/defconfig
--- linux-2.5.50/arch/x86_64/defconfig	Tue Oct 22 00:13:59 2002
+++ linux-2.5.50-eaa/arch/x86_64/defconfig	Tue Dec  3 00:48:05 2002
@@ -594,7 +594,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_FS is not set
