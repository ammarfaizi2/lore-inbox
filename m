Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbUBCQZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUBCQY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:24:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:6311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266029AbUBCQYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:24:16 -0500
From: john cherry <cherry@osdl.org>
Date: Tue, 3 Feb 2004 08:24:14 -0800
Message-Id: <200402031624.i13GOED18911@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2-rc3 - 2004-02-02.17.30) - 1 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ide/ide-generic.c:17: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:488)
