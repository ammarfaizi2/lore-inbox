Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRHFGRa>; Mon, 6 Aug 2001 02:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbRHFGRT>; Mon, 6 Aug 2001 02:17:19 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:29959 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266867AbRHFGRI>;
	Mon, 6 Aug 2001 02:17:08 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Gergely Madarasz <gorgo@itc.hu>
Subject: 2.4.8-pre4 drivers/net/wan/comx.c unresolved symbol
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 16:17:14 +1000
Message-ID: <1101.997078634@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably already known but 2.4.8-pre4 drivers/net/wan/comx.c
has an unresolved symbol proc_get_inode when compiled as a module.

I was pleasently suprised when doing a full kernel compile as modules.
840 modules created, only one unresolved symbol.

