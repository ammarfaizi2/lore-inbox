Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUA2KoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUA2KoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:44:07 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:18654 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264917AbUA2KoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:44:04 -0500
Date: Thu, 29 Jan 2004 12:44:02 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: 2.6.2-rc2 Interactivity problems with SMP + HT
Message-ID: <Pine.LNX.4.58.0401291239320.23046@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

First, thank you very much for the effort you put for Linux!

I have a Intel motherboard with SATA (2 Maxtor disks).
CPUs: 2 x 2.4GHz PIV HT = 4 processors (2 virtual)
1 GB RAM.

Load: postgresql and apache. Very low load (3-4 clients).

RAID: Yes, soft RAID1 between the 2 disks.

I have times when the console freeze for 3-4 seconds!
2.6.0-test11 had the same problem (maybe longer times).
2.6.1-rc2 worked good in this respect but crashed after 2 days. :(
2.6.2-rc2 is back with the delay.

Do you know why this can happen?

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
