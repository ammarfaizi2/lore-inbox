Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSLCNPi>; Tue, 3 Dec 2002 08:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLCNPh>; Tue, 3 Dec 2002 08:15:37 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:26540 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261333AbSLCNPg>; Tue, 3 Dec 2002 08:15:36 -0500
Date: Tue, 3 Dec 2002 14:22:51 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Niibe Yutaka <gniibe@m17n.org>,
       linux-sh@m17n.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (sh)
Message-ID: <20021203132251.GK2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused CONFIG_UDF_RW from sh defconfig

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/sh/defconfig linux-2.5.50-eaa/arch/sh/defconfig
--- linux-2.5.50/arch/sh/defconfig	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/sh/defconfig	Tue Dec  3 00:48:05 2002
@@ -170,7 +170,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_NCPFS_NLS is not set
