Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUJSMZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUJSMZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUJSMZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:25:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:10692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268207AbUJSMZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:25:43 -0400
Date: Tue, 19 Oct 2004 05:25:42 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410191225.i9JCPgEM016530@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9 - 2004-10-18.21.30) - 8 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ieee1394/sbp2.h:61:1: warning: "ABORT_TASK_SET" redefined
drivers/ieee1394/sbp2.h:62:1: warning: "LOGICAL_UNIT_RESET" redefined
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:229: warning: large integer implicitly truncated to unsigned type
drivers/scsi/ncr53c8xx.c:7746: warning: `ncr53c8xx_setup' defined but not used
drivers/scsi/sym53c8xx_2/sym_glue.c:1976: warning: unused variable `base'
include/linux/compiler.h:20: warning: parameter name starts with a digit in #define
include/scsi/scsi.h:255:1: warning: this is the location of the previous definition
include/scsi/scsi.h:267:1: warning: this is the location of the previous definition
