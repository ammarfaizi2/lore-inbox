Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUJBJR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUJBJR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUJBJR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:17:58 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:32232 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266349AbUJBJR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:17:57 -0400
Date: Sat, 2 Oct 2004 11:16:44 +0200
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3-mm1 build failure
Message-ID: <20041002091644.GA8431@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x111f5): In function `end_level_ioapic_irq':
: undefined reference to `irq_mis_count'
kernel/built-in.o(.text+0x1eba7): In function `ack_none':
: undefined reference to `ack_APIC_irq'
make[1]: *** [.tmp_vmlinux1] Fehler 1
make[1]: Leaving directory `/usr/src/linux-2.6.9-rc3-mm1'


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GLENWHILLY (n. Scots)
A small tartan pouch worn beneath the kilt during the thistle-harvest.
			--- Douglas Adams, The Meaning of Liff
