Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUAVSLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUAVSLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:11:46 -0500
Received: from main.gmane.org ([80.91.224.249]:896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266271AbUAVSLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:11:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: [net/8139cp] still crashes my notebook
Date: Thu, 22 Jan 2004 19:11:36 +0100
Message-ID: <slrnc104io.mp.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

my notebook (hp/compaq nx7000) still crashes when using 8139cp (runs
rock solid with 8139too driver). The computer just locks up, there is no
dmesg output. This has happened since I've got this laptop (around
november '03).

8139too outputs:
| 8139too Fast Ethernet driver 0.9.27
| 8139too: pci dev 0000:02:01.0 (id 10ec:8139 rev 20) is an enhanced 8139C+ chip
| 8139too: Use the "8139cp" driver for improved performance and stability.
| 8139too: 0000:02:01.0: unknown chip version, assuming RTL-8139
| 8139too: 0000:02:01.0: TxConfig = 0x74800000

the "Use the.." line is rather annoying..

lspci lists:
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 20)

	--Andreas


