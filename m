Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbUDQIxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUDQIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:53:06 -0400
Received: from pop.gmx.net ([213.165.64.20]:5508 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263732AbUDQIxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:53:04 -0400
X-Authenticated: #1226656
Date: Sat, 17 Apr 2004 10:53:03 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: Linux on UltraSparcII E450
Message-Id: <20040417105303.7936e413@vaio.gigerstyle.ch>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Last week I had the honor to install Linux on a E450 with 2 cpu's. All
went fine at first. Long compiling sessions were no problem for the
machine. Later we installed 16 additional SCSI disks and we built 
4 x Soft-RAID5 groups with 4 disks each.
After some time during the sync processes the machine stops responding.
Simply dead. The same thing happens after every boot when the sync
process is in action.

My question now is: Is it a hardware or a kernel problem? I now it isn't
a simple question with the given infos.
Is it possible that the 4 parallel sync processes are to much for the
SCSI (standard LSI) controllers?
I assume that the kernel RAID5 code is stable on sparc?!

Thank you

Regards

Marc
