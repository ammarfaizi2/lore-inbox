Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUCMNnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbUCMNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:43:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:26049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263092AbUCMNnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:43:39 -0500
Date: Sat, 13 Mar 2004 05:43:38 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403131343.i2DDhcpw025834@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.4 - 2004-03-12.22.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/applicom.c:523:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
drivers/char/watchdog/cpu5wdt.c:305: warning: initialization discards qualifiers from pointer target type
drivers/char/watchdog/cpu5wdt.c:305: warning: return discards qualifiers from pointer target type
drivers/message/fusion/mptscsih.c:1066: warning: `mptscsih_reset_timeouts' defined but not used
