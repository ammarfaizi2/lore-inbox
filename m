Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280494AbRLDCip>; Mon, 3 Dec 2001 21:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280646AbRLCXvn>; Mon, 3 Dec 2001 18:51:43 -0500
Received: from albaycin.moebius.es ([217.18.164.132]:33294 "EHLO
	albaycin.moebius.es") by vger.kernel.org with ESMTP
	id <S284568AbRLCNxd>; Mon, 3 Dec 2001 08:53:33 -0500
Message-ID: <3C0B921F.80206@subdimension.com>
Date: Mon, 03 Dec 2001 14:54:23 +0000
From: real <haxmail@subdimension.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011201
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compilation error with Kernels 2.4.16 && 2.5.X
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols 
in discarded section .text.exit'
drivers/net/net.o(.data+0xbb4): undefined reference to `local symbols in 
discarded section .text.exit'
drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local 
symbols in discarded section .text.exit'
drivers/usb/usbdrv.o(.data+0x234): undefined reference to `local symbols 
in discarded section .text.exit'
make: *** [vmlinux] Error 1


