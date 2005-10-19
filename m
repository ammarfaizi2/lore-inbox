Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVJSKrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVJSKrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 06:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVJSKrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:47:31 -0400
Received: from 204.4.76.83.cust.bluewin.ch ([83.76.4.204]:1846 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S964786AbVJSKra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:47:30 -0400
Date: Wed, 19 Oct 2005 12:47:12 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Sequence of network cards
Message-ID: <20051019104712.GC9765@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a PCI machine with 2.4.25 kernel with 4 network cards:
eth0, IRQ 11, 3Com Corporation 3c900 Combo [Boomerang] (rev 0)
eth1, IRQ 5, 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 116).
eth2, IRQ 10, nVidia Corporation nForce2 Ethernet Controller (rev 161)
eth3, IRQ 3, Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16)

Will the sequence of network cards change when I upgrade to 2.6.13.4?
All the drivers are compiled directly into kernel, not as modules.

Is the algorithm for assignment of eth? numbers by Linux kernel
documented anywhere?

CL<

