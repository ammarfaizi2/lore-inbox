Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbULLNbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbULLNbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 08:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbULLNbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 08:31:38 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:54162 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261812AbULLNbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 08:31:36 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041212133157.10640.78951.94237@localhost.localdomain>
Subject: [PATCH] moxa: Remove README.moxa from Documentation/00-INDEX
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.220.243] at Sun, 12 Dec 2004 07:31:35 -0600
Date: Sun, 12 Dec 2004 07:31:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch depends on patch submitted earlier to remove README.moxa.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-original/Documentation/00-INDEX linux-2.6.10-rc3/Documentation/00-INDEX
--- linux-2.6.10-rc3-original/Documentation/00-INDEX	2004-12-03 16:52:57.000000000 -0500
+++ linux-2.6.10-rc3/Documentation/00-INDEX	2004-12-12 08:28:05.348799825 -0500
@@ -40,8 +40,6 @@
 	- directory with info on RCU (read-copy update).
 README.DAC960
 	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux.
-README.moxa
-	- release notes for Moxa mutiport serial card.
 SAK.txt
 	- info on Secure Attention Keys.
 SubmittingDrivers
