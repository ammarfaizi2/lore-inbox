Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbULVVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbULVVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 16:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbULVVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 16:49:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:34499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbULVVtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 16:49:23 -0500
Date: Wed, 22 Dec 2004 13:49:10 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200412222149.iBMLnAcW032713@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.10-rc3 - 2004-12-22.8.00) - 9 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/mmc/mmc.c:332: warning: left shift count >= width of type
drivers/mmc/mmc.c:336: warning: left shift count >= width of type
drivers/mmc/mmc.c:350: warning: left shift count >= width of type
drivers/mmc/mmc.c:354: warning: left shift count >= width of type
drivers/mmc/mmc.c:356: warning: left shift count >= width of type
drivers/mmc/mmc.c:397: warning: left shift count >= width of type
drivers/mmc/mmc_block.c:183: warning: `req' is deprecated (declared at include/linux/mmc/mmc.h:60)
drivers/mmc/wbsd.c:208: warning: `req' is deprecated (declared at include/linux/mmc/mmc.h:60)
drivers/mmc/wbsd.c:208: warning: unused variable `req'
