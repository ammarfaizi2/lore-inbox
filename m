Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277111AbRJIMpc>; Tue, 9 Oct 2001 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRJIMpV>; Tue, 9 Oct 2001 08:45:21 -0400
Received: from hera.society.de ([195.227.57.7]:53265 "EHLO hera.society.de")
	by vger.kernel.org with ESMTP id <S277111AbRJIMpH>;
	Tue, 9 Oct 2001 08:45:07 -0400
Date: Tue, 9 Oct 2001 14:46:26 +0200
From: Bernfried Molte <bbm@studioorange.de>
To: linux-kernel@vger.kernel.org
Subject: ifconfig exit_signal 17 in reparent_to_init
Message-Id: <20011009144626.475a8d6e.bbm@studioorange.de>
Organization: Studioorange
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, i thought this was done...
got this message with 2.4.10-ac10 + preempt-patch:

Oct  9 14:31:59 lichee kernel: task `ifconfig' exit_signal 17 in reparent_to_init

Oct  9 14:33:18 lichee kernel: 8139too Fast Ethernet driver 0.9.18a
Oct  9 14:33:18 lichee kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xd085d000, 00:e0:7d:7c:f8:d8, IRQ 11
Oct  9 14:33:18 lichee kernel: eth0:  Identified 8139 chip type 'RTL-8139B'
Oct  9 14:33:18 lichee kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

cheers, bernfried molte

---
