Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265752AbTL3LIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbTL3LIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:08:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:38603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265752AbTL3LIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:08:50 -0500
Date: Tue, 30 Dec 2003 03:08:47 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200312301108.hBUB8lxF021053@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0 - 2003-12-29.22.30) - 5 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/sk98lin/skaddr.c:1092: warning: `ReturnCode' might be used uninitialized in this function
drivers/net/sk98lin/skaddr.c:1624: warning: `ReturnCode' might be used uninitialized in this function
drivers/net/wan/cycx_drv.c:430: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/usb/media/pwc-if.c:1124: warning: control reaches end of non-void function
drivers/usb/media/pwc-if.c:1855: warning: assignment from incompatible pointer type
