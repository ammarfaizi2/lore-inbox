Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUBJQdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUBJQdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:33:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:62367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266006AbUBJQcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:32:52 -0500
From: john cherry <cherry@osdl.org>
Date: Tue, 10 Feb 2004 08:32:50 -0800
Message-Id: <200402101632.i1AGWoA18655@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3-rc1 - 2004-02-09.17.30) - 3 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/wan/pc300_tty.c:265: warning: cast to pointer from integer of different size
drivers/net/wan/pc300_tty.c:700: warning: cast from pointer to integer of different size
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
