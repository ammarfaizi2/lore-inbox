Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVJREd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVJREd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbVJREd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:33:26 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:34442 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1751437AbVJREdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:33:25 -0400
Subject: ATA warnings in dmesg
From: Aaron Gyes <floam@sh.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 17 Oct 2005 21:33:19 -0700
Message-Id: <1129609999.10504.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last few -mm releases (maybe longer, maybe it's in non-mm also)
my dmesg is full of this:

ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00

I've got a Western Digital Raptor 74GB, using sata-via on a K8T800 Pro.
Should I be scared?

Aaron Gyes

