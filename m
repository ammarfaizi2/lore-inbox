Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266380AbUHCNgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUHCNgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUHCNgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:36:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:44761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266380AbUHCNgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:36:19 -0400
Date: Tue, 3 Aug 2004 06:36:18 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408031336.i73DaIWK004966@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8-rc2 - 2004-08-02.22.30) - 5 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/dvb/frontends/alps_tdlb7.c:58: warning: `errno' defined but not used
drivers/media/dvb/frontends/sp887x.c:70: warning: `errno' defined but not used
drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but not used
drivers/scsi/fdomain.c:438: warning: `ports' defined but not used
drivers/scsi/fdomain.c:665: warning: `fdomain_get_irq' defined but not used
