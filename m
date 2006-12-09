Return-Path: <linux-kernel-owner+w=401wt.eu-S1161734AbWLIQaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161734AbWLIQaO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 11:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161722AbWLIQaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 11:30:14 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:38915 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937061AbWLIQaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 11:30:13 -0500
Date: Sat, 9 Dec 2006 16:26:26 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [ATM] Ignore generated file pca200e_ecd.bin2
Message-ID: <20061209162626.GA13788@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/atm/.gitignore b/drivers/atm/.gitignore
index a165b71..fc0ae5e 100644
--- a/drivers/atm/.gitignore
+++ b/drivers/atm/.gitignore
@@ -2,4 +2,4 @@ # Ignore generated files
 fore200e_mkfirm
 fore200e_pca_fw.c
 pca200e.bin
-
+pca200e_ecd.bin2
