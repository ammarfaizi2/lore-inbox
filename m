Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbUDNMji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbUDNMjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:39:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:26822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263993AbUDNMhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:37:55 -0400
Date: Wed, 14 Apr 2004 05:37:54 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200404141237.i3ECbsXX005667@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.5 - 2004-04-13.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/tulip/timer.c:156: warning: unused variable `ioaddr'
