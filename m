Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUK2Kdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUK2Kdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUK2Kdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:33:43 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18323 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261651AbUK2Kd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:33:27 -0500
Date: Mon, 29 Nov 2004 19:35:00 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [ANNOUNCE 0/7] Diskdump 1.0 Release
To: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!
I release diskdump 1.0 for kernel 2.6.9. It can be downloaded from
the following site. Please feel free to use it!
   http://sourceforge.net/projects/lkdump

Diskdump project is a joint development of RedHat and Fujitsu, and I'd 
like to express my gratitude to a RedHat developers for many comments
and advices.

<Supported architecture>
- i386
- x86_64
- ia64
- ppc64 (New features supported by IBM)

<Supported disk>
- IDE disk (New features)
- SCSI disk which is connected to the following adapter
   o aic7xxx
   o aic79xx
   o Fusion MPT ScsiHost Driver
   o sym53c8xx (New features supported by IBM)
   o IBM Power Linux RAID (New features supported by IBM)

I prepare a mailing list for diskdump development. Please send a mail to 
this list if you have any comments.
   lkdump-develop at lists.sourceforge.net

I'd like to thank IBM, NEC and HITACHI developers for their cooperation.
Of course, I'd like to thank all people who gave me comments and advices
on LKML.


Best Regards,
Takao Indoh

