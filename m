Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTLaLck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLaLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:32:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:13465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263561AbTLaLck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:32:40 -0500
Date: Wed, 31 Dec 2003 03:32:38 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200312311132.hBVBWcg6008411@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.1 - 2003-12-30.22.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aacraid/aachba.c:1409: warning: `flag' might be used uninitialized in this function
drivers/scsi/eata_generic.h:84:1: warning: "TIMEOUT" redefined
drivers/scsi/inia100.c:421: warning: `pHCB' might be used uninitialized in this function
include/scsi/scsi.h:305:1: warning: this is the location of the previous definition
