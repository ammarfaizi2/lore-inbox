Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUJDS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUJDS6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUJDS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:58:42 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:7333 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S268409AbUJDS6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:58:36 -0400
From: age huisman <ahuisman@cistron.nl>
Subject: drivers/scsi/sata_sil.c
Date: Mon, 04 Oct 2004 20:58:35 +0200
Organization: Cistron
Message-ID: <cjs6gr$mn5$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ncc1701.cistron.net 1096916315 23269 62.216.17.166 (4 Oct 2004 18:58:35 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- a/drivers/scsi/sata_sil.c 2004-08-14 12:38:51 -07:00
+++ b/drivers/scsi/sata_sil.c 2004-09-13 19:35:23 -07:00
@@ -108,7 +108,7 @@
.name = DRV_NAME,
.detect = ata_scsi_detect,
.release = ata_scsi_release,
- .ioctl = ata_scsi_ioctl,
+ .ioctl = ata_scsi_ioctl,

^^^^^^^^^^^^^^^^^^^^^^^^^

?????? see no difference  :-)


Age Huisman



