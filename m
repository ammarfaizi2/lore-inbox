Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUGMFF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUGMFF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 01:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUGMFF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 01:05:29 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:46095 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263802AbUGMFFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 01:05:24 -0400
Message-ID: <57861437040712220518dee67d@mail.gmail.com>
Date: Tue, 13 Jul 2004 00:05:10 -0500
From: Jesus Delgado <jdelgado@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Broken driver via-rhine.c in kernel 2.6.8-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 hi:

The problems with driver via-rhine.c version v1.10-LK1.1.20-2.6
May-23-2004:via-rhine: probe of 0000:00:12.0 failed with error -5
Invalid MAC address for card #0

kernel 2.6.7 and kernel 2.6.7-mm7  working good via-rhine.c

The version via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004: working good:

via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
PCI: Found IRQ 9 for device 0000:00:12.0
PCI: Sharing IRQ 9 with 0000:00:0c.0
PCI: Sharing IRQ 9 with 0000:00:10.0
PCI: Sharing IRQ 9 with 0000:00:11.1
PCI: Sharing IRQ 9 with 0000:01:00.0
divert: allocating divert_blk for eth0
eth0: VIA Rhine II (VT8235) at 0xd0002c00, 00:03:25:0d:9e:58, IRQ 9.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 41e1.
