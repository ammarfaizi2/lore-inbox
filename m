Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTAUVtw>; Tue, 21 Jan 2003 16:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbTAUVtw>; Tue, 21 Jan 2003 16:49:52 -0500
Received: from dialin-145-254-061-026.arcor-ip.net ([145.254.61.26]:1664 "EHLO
	portable.localnet") by vger.kernel.org with ESMTP
	id <S267239AbTAUVtv> convert rfc822-to-8bit; Tue, 21 Jan 2003 16:49:51 -0500
Date: Tue, 21 Jan 2003 22:56:34 +0100 (CET)
Message-Id: <20030121.225634.730550855.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: PCMCIA and Adaptec 1460
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 2.2 on XEmacs 21.4.10 (Military Intelligence)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I use an Adaptec "APA-1460 SCSI Host Adapter" with kernel 2.4.20 and
wonder why the I/O causes that much CPU useage (100% sometimes). Has
PCMCIA no kind of DMA?

My laptop has this cardbus bridge:

00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)

I also managed to crash the driver sometimes during SANE/Avision
user-space code development. Nearly complete freeze - but Sysrq does
still work - maybe anyone is interested in an OOPS I might be able to
log via the serial line?

Any ideas?

Thanks
  - René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene.rebe@gmx.net, rene@rocklinux.org
web:      www.rocklinux.org, drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

