Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265888AbTF3UjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbTF3UjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:39:13 -0400
Received: from mail.highstream.net ([65.214.41.101]:23823 "EHLO highstream.net")
	by vger.kernel.org with ESMTP id S265888AbTF3UjK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:39:10 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: gilson r <gilsonr@highstream.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.72 doesn't load up
Date: Mon, 30 Jun 2003 16:55:06 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306301655.06221.gilsonr@highstream.net>
X-Note: This E-mail was scanned for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just as when I tried 2.5.64, I get now the same result with 2.5.72.
When I reboot with the new kernel, I get:
   "Booting 'Linux-2.5.72'
   kernel (hd1,14)/vmlinuz-2.5.72 ro root=/dev/hdb2 hdc=ide-scsi
 [Linux - bzImage, setup=0x1400, size=0xdd72f]
   initrd (hd1,14)/initrd-2.5.72.img
 [Linux - initrd @ 0xf7cb000, 0x14d14 bytes]
 Uncompressing Linux... Ok, booting the kernel."
And it hangs there, whether I compile with Mandrake-9.1 or RedHat-8.
I'd love to learn what I'm doing wrong.
Kindly CC to me.

-- 
Regards,
gilson
(in /usually/ sunny, balmy, Florida's Suncoast)
[this is an Intel-free, M$-free, virus-free computer.
Not by chance: powered by AMD-Duron running
MandrakeSoft-9.1/Linux-2.4.21, RedHat-8.0/Linux-2.4.18]
