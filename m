Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUFFSYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUFFSYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUFFSYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:24:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:7395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263979AbUFFSXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:23:42 -0400
Date: Sun, 6 Jun 2004 11:23:37 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200406061823.i56INbCg028820@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7-rc2 - 2004-06-05.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/synclink.c:4559: warning: control reaches end of non-void function
