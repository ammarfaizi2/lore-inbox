Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUIXQyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUIXQyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIXQwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:52:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:9124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268968AbUIXQrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:47:04 -0400
Date: Fri, 24 Sep 2004 09:46:59 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409241646.i8OGkx2V017096@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc2 - 2004-09-23.21.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/atm/ambassador.c:2297: warning: unsigned int format, long unsigned int arg (arg 2)
