Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHWMvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHWMvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUHWMvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 08:51:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:5585 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263775AbUHWMvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 08:51:20 -0400
Date: Mon, 23 Aug 2004 05:51:19 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408231251.i7NCpJDK006874@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8.1 - 2004-08-22.21.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/cpufreq/cpufreq_userspace.c:157:2: warning: #warning The /proc/sys/cpu/ and sysctl interface to cpufreq will be removed from the 2.6. kernel series soon after 2005-01-01
drivers/cpufreq/proc_intf.c:15:2: warning: #warning This module will be removed from the 2.6. kernel series soon after 2005-01-01
drivers/net/via-velocity.c:3089: warning: implicit declaration of function `crc16'
