Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbUATLq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUATLq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:46:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:24528 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265363AbUATLq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:46:56 -0500
Date: Tue, 20 Jan 2004 03:46:52 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200401201146.i0KBkqZ1003046@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.1 - 2004-01-19.22.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aha152x.c:1099: warning: `aha152x_init' defined but not used
drivers/scsi/aha152x.c:1386: warning: `aha152x_exit' defined but not used
drivers/scsi/qla1280.c:3127: warning: `qla1280_64bit_start_scsi' defined but not used
fs/afs/inode.c:207: warning: implicit declaration of function `_leave'
