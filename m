Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264039AbUD0MnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbUD0MnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbUD0MnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:43:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:17388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264039AbUD0MnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:43:18 -0400
Date: Tue, 27 Apr 2004 05:43:17 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200404271243.i3RChHL8011857@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6-rc2 - 2004-04-26.22.30) - 5 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "errno" [drivers/media/dvb/frontends/tda1004x.ko] undefined!
drivers/media/dvb/frontends/alps_tdlb7.c:162: warning: implicit declaration of function `sys_close'
drivers/media/dvb/frontends/sp887x.c:224: warning: implicit declaration of function `sys_close'
drivers/media/dvb/frontends/tda1004x.c:409: warning: implicit declaration of function `sys_close'
drivers/media/dvb/ttpci/budget-ci.c:406: warning: `ciintf_init' defined but not used
