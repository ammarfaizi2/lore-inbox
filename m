Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUBBLUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUBBLUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:20:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:19356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265365AbUBBLUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:20:24 -0500
Date: Mon, 2 Feb 2004 03:20:23 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402021120.i12BKNCZ031592@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.2-rc3 - 2004-02-01.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ide/ide-generic.c:17: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:488)
