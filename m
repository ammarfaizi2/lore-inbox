Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUBXVGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUBXVGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:06:37 -0500
Received: from web41204.mail.yahoo.com ([66.218.93.37]:19600 "HELO
	web41204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262461AbUBXVFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:05:45 -0500
Message-ID: <20040224210544.15843.qmail@web41204.mail.yahoo.com>
Date: Tue, 24 Feb 2004 13:05:44 -0800 (PST)
From: Jin Suh <jinssuh@yahoo.com>
Subject: [2.4.25] hdb: dma-timer-expiry: dma status=0x61, error waiting for DMA
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently upgraded my kernel to 2.4.25 on Dell 530 dual Xeons/2gb RAM. I had
the following error twice. 

hdb: dma-timer-expiry: dma status=0x61
hdb: error waiting for DMA

Then the system gets hung. It happens in the morning when I hit the enter key
at the command prompt to refresh my system. Did I set the wrong DMA in the
kernel configuration? I enabled the followings:

Generic PCI bus-master DMA support
Use PCI DMA by default when available

Could someone help me?

Thanks,
Jin


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
