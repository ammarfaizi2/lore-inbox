Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbRLTAOR>; Wed, 19 Dec 2001 19:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285663AbRLTAOH>; Wed, 19 Dec 2001 19:14:07 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:8152 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S285669AbRLTANy>; Wed, 19 Dec 2001 19:13:54 -0500
Date: Thu, 20 Dec 2001 01:13:48 +0100 (CET)
From: Michael De Nil <linux@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.16 -> undefined reference to `local symbols ...
Message-ID: <Pine.LNX.4.43.0112200109380.424-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried now several times to 'make' the 2.4.16-kernel, but I get allways
the same error:

...
a /usr/src/linux-2.4.16/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
in discarded section .text.exit'
make: *** [vmlinux] Error 1

I tried downloading the tarball again several times, but I get the same
error every time.

tnx
	michael



