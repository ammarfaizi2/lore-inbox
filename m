Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUJKMqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUJKMqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJKMpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:45:07 -0400
Received: from mail.bfi-burgenland.at ([213.33.127.134]:26340 "EHLO
	mailrelay.bfi-burgenland.at") by vger.kernel.org with ESMTP
	id S268899AbUJKMmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:42:53 -0400
Subject: Kernel hang when checking partitions on SATA drive (SCSI-libsata,
	VIA SATA)
From: Andreas Grabner <a.grabner@bfi-burgenland.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1097498573.20515.24.camel@sprint150>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 14:42:53 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "jupiter.ow.bfi-bgld.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	http://www.bfi-ma.at/spam/ for details.
	Content preview:  Hello, please CC me to your replies as I'm not
	currently a subscriber; thanks in advance. I have a Problem with kernel
	2.6.8.1 and maybe the sata_via driver. It hang while booting. The
	following messages appear: [...] 
	Content analysis details:   (0.0 points, 9.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
please CC me to your replies as I'm not currently a subscriber; thanks in
advance.

I have a Problem with kernel 2.6.8.1 and maybe the sata_via driver. It hang while booting.
The following messages appear:

SCSI device sda: 390721968 512-byte hdwr sectors (2000050MB)
SCSI device sda: drive cache: write back
sda:<3>ata1: command 0x25 timeout, stat 0x50 host_stat 0x4
after 5 seconds:
sda1 sda2 sda3 sda4 <
then there is nothing more.

Kernel 2.4.25 works so i think my Hardware (A7V600-X, Sempron 2800+, SEGATE ST3200822AS) is ok.
Any hints what is wrong? Thanks in advance for your help.

Best Regards,
Andreas Grabner

