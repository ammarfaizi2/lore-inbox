Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUIDOkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUIDOkD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 10:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUIDOkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 10:40:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:18849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbUIDOkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 10:40:01 -0400
Date: Sat, 4 Sep 2004 07:39:57 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409041439.i84EdvB0007501@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc1 - 2004-09-03.21.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/cs89x0.c:1709: warning: `use_dma' defined but not used
drivers/net/cs89x0.c:1710: warning: `dma' defined but not used
drivers/net/cs89x0.c:1711: warning: `dmasize' defined but not used
