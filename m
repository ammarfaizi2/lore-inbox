Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270871AbTHKCRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270877AbTHKCRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:17:46 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:16914
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S270871AbTHKCRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:17:45 -0400
Date: Sun, 10 Aug 2003 19:17:50 -0700
To: linux-kernel@vger.kernel.org
Subject: VIA Serial ATA chipset
Message-ID: <20030811021750.GA5077@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am wondering if the VIA Serial ATA chipset found with the VIA KT600
chipset is yet supported. An lspci -v reveals:

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device
3149 (rev 80)
        Subsystem: VIA Technologies, Inc.: Unknown device 3149
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at 8800 [size=8]
        I/O ports at 8400 [size=4]
        I/O ports at 8000 [size=8]
        I/O ports at 7800 [size=4]
        I/O ports at 7400 [size=16]
        I/O ports at 7000 [size=256]
        Capabilities: [c0] Power Management version 2

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
