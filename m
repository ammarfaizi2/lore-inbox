Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTJQGY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 02:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbTJQGY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 02:24:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:59061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263312AbTJQGYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 02:24:55 -0400
Date: Thu, 16 Oct 2003 23:24:54 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310170624.h9H6Os22031925@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test7 - 2003-10-16.18.30) - 11 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/applicom.c:522:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
drivers/net/arcnet/arc-rimi.c:319: warning: `dev_alloc' is deprecated (declared at include/linux/netdevice.h:516)
drivers/net/arcnet/com20020-isa.c:152: warning: `dev_alloc' is deprecated (declared at include/linux/netdevice.h:516)
drivers/net/arcnet/com20020-pci.c:71: warning: `dev_alloc' is deprecated (declared at include/linux/netdevice.h:516)
drivers/net/arcnet/com90io.c:385: warning: `dev_alloc' is deprecated (declared at include/linux/netdevice.h:516)
drivers/net/arcnet/com90xx.c:412: warning: `dev_alloc' is deprecated (declared at include/linux/netdevice.h:516)
drivers/net/arcnet/com90xx.c:609: warning: `dev_alloc' is deprecated (declared at include/linux/netdevice.h:516)
sound/oss/msnd.c:74: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
sound/oss/msnd.c:95: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
sound/oss/msnd_pinnacle.c:1123: warning: `check_region' is deprecated (declared at include/linux/ioport.h:118)
sound/oss/msnd_pinnacle.c:1811: warning: `check_region' is deprecated (declared at include/linux/ioport.h:118)
