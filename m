Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273004AbTHPO3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273015AbTHPO3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:29:38 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:21477 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S273004AbTHPO3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:29:37 -0400
Date: Sat, 16 Aug 2003 06:51:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: axel@pearbough.net
Subject: [Bug 1116] New: build error in drivers/scsi/ide-scsi.c
Message-ID: <32230000.1061041877@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1116

           Summary: build error in drivers/scsi/ide-scsi.c
    Kernel Version: 2.6.0-test3-bk
            Status: NEW
          Severity: high
             Owner: andmike@us.ibm.com
         Submitter: axel@pearbough.net


Distribution:Slackware-9.0
Hardware Environment:
Software Environment:
Problem Description:build fails at drivers/scsi/ide-scsi.c:951
drivers/scsi/ide-scsi.c:951: error: unknown field `name' specified in initializer
Steps to reproduce:drivers/scsi/ide-scsi.c:951: warning: missing braces around initializer
drivers/scsi/ide-scsi.c:951: warning: (near initialization for `idescsi_primary.node')
drivers/scsi/ide-scsi.c:951: warning: initialization from incompatible pointer type


