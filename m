Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUICPZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUICPZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269238AbUICPWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:22:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:44523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269280AbUICPSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:18:55 -0400
Date: Fri, 3 Sep 2004 08:18:52 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409031518.i83FIqXK003470@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc1 - 2004-09-02.21.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/wan/pc300_tty.c:763: warning: `new' might be used uninitialized in this function
