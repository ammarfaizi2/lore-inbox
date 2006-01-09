Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWAIRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWAIRBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWAIRBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:01:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:34452 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964818AbWAIRBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:01:09 -0500
Subject: PATCH: Update TODO list for pata_amd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 17:03:28 +0000
Message-Id: <1136826208.6659.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to do this before submitting that revision to Jeff

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-mm2/drivers/scsi/pata_amd.c linux-2.6.15-mm2/drivers/scsi/pata_amd.c
--- linux.vanilla-2.6.15-mm2/drivers/scsi/pata_amd.c	2006-01-09 14:33:45.000000000 +0000
+++ linux-2.6.15-mm2/drivers/scsi/pata_amd.c	2006-01-09 14:46:21.000000000 +0000
@@ -10,8 +10,6 @@
  *  TODO:
  *	Nvidia support here or seperated ?
  *	Debug cable detect
- *	MWDMA/SWDMA
- *	Port the ide-timing.h functionality
  *	Variable system clock when/if it makes sense
  *	Power management on ports
  *

