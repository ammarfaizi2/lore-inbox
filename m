Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTIWGkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 02:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTIWGkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 02:40:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:51852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263333AbTIWGkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 02:40:07 -0400
Date: Mon, 22 Sep 2003 23:40:06 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309230640.h8N6e6RN012095@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/tokenring/smctr.c:3494: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/net/tokenring/smctr.c:733: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
net/llc/llc_output.c:51: warning: implicit declaration of function `tr_source_route'
net/wanrouter/wanmain.c:729: warning: `dev_get' is deprecated (declared at include/linux/netdevice.h:507)
