Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUH2NBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUH2NBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUH2NBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:01:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:1483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267795AbUH2NBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:01:33 -0400
Date: Sun, 29 Aug 2004 06:01:31 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408291301.i7TD1V1A001393@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc1 - 2004-08-28.21.30) - 8 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aic7xxx/aic79xx_osm.c:419: warning: `aic79xx' defined but not used
drivers/scsi/aic7xxx/aic79xx_osm.c:425: warning: `dummy_buffer' defined but not used
drivers/scsi/aic7xxx/aic7xxx_osm.c:440: warning: `aic7xxx' defined but not used
drivers/scsi/aic7xxx/aic7xxx_osm.c:446: warning: `dummy_buffer' defined but not used
drivers/scsi/megaraid/megaraid_mm.c:49:1: warning: "register_ioctl32_conversion" redefined
drivers/scsi/megaraid/megaraid_mm.c:50:1: warning: "unregister_ioctl32_conversion" redefined
include/linux/ioctl32.h:32:1: warning: this is the location of the previous definition
include/linux/ioctl32.h:33:1: warning: this is the location of the previous definition
