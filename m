Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTITBrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 21:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTITBrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 21:47:17 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:41767 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261347AbTITBrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 21:47:17 -0400
Message-ID: <00d001c37f19$2723bf70$22646b81@sigma>
From: "Anoop" <anoopr@myrealbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Partition Error in 2.6.0test5
Date: Fri, 19 Sep 2003 20:47:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, My name is Anoop. I have a problem with the 2.6.0test5 kernel. It gives
me an error saying that the partitions are not aligned, when I try to print
the partition table, using fdisk. I have a Pheonix Bios and a 40GB HDD,
running on my laptop. I have already disabled the "Auto-resize geometry"
option in the kernel. I also have a problem with the Framebuffer during
bootup. It shows a horribly distorted screen if I try to boot with "vga=791"
option. "vga=normal" gives me no problem though. I had neither problems with
the 2.4.x kernels.Any ideas?
Thanks
Anoop

