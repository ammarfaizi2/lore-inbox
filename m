Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTJWGY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 02:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJWGY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 02:24:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:2221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbTJWGY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 02:24:58 -0400
Date: Wed, 22 Oct 2003 23:24:57 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310230624.h9N6OvVk026304@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test8 - 2003-10-22.18.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/libata-core.c:2122: warning: `ata_qc_push' defined but not used
drivers/scsi/sata_promise.c:293: warning: `pdc_prep_lba28' defined but not used
drivers/scsi/sata_promise.c:323: warning: `pdc_prep_lba48' defined but not used
drivers/usb/serial/digi_acceleport.c:1732: warning: assignment from incompatible pointer type
