Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTIGFCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTIGFCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:02:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:34284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261240AbTIGFCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:02:10 -0400
Date: Sat, 6 Sep 2003 22:02:06 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309070502.h87526ML007003@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 1 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/mwave/mwavedd.c:331:2: warning: #warning "Sleeping on spinlock"
