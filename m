Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTJRGoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbTJRGoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:44:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:9926 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261406AbTJRGoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:44:46 -0400
Date: Fri, 17 Oct 2003 23:44:44 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310180644.h9I6iieH020718@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test8 - 2003-10-17.18.30) - 5 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/3c515.c:610: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)
drivers/net/atp.c:299: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)
drivers/net/lance.c:452: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)
drivers/net/wireless/arlan-main.c:1099: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)
drivers/net/znet.c:390: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)
