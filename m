Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKPCSQ>; Wed, 15 Nov 2000 21:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKPCSH>; Wed, 15 Nov 2000 21:18:07 -0500
Received: from dns.buddysync.com.sg ([203.126.129.188]:55563 "EHLO
	www.cyberlab.com.sg") by vger.kernel.org with ESMTP
	id <S129045AbQKPCR4>; Wed, 15 Nov 2000 21:17:56 -0500
Message-ID: <3A133CC5.45069C9@ieee.org>
Date: Thu, 16 Nov 2000 09:47:49 +0800
From: Chng Tiak-Jung <tiakjung@ieee.org>
Reply-To: tiakjung@ieee.org
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-dp1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Carlisle <Matthewc@aeimusic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NatSemi CS5530 Sound Support
In-Reply-To: <1DA9F58AA962D4118EAE00508B5BD5439B8F7F@MAIL01SEA>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Carlisle wrote:
> Are there any plans to develop kernel sound driver support for the
> Cyrix/NatSemi CS5530 chipset?  I noticed PCI and IDE support for this
> chipset in the kernel source, but nothing for the sound.  I have a NatSemi
> Geode GXLV processor, NatSemi Geode CS5530 chipset, and the AC97 codec that
> NatSemi recommends (although I'm sure any one will do).  So I can act as an
> alpha/beta/gamma/zappa tester!  :)

Go register as a developer on National Semiconductor's website and you
can download the source to the native audio support for CS5530. However,
my understanding is that this driver will only work on system with BIOS
that support VSA2, so you may need to upgrade your BIOS first.

Regards,
T J
--
Chng Tiak-Jung                          tiak-jung.chng@eno.ericsson.se
Cyberlab Singapore, Ericsson Research                Tel: +65-880-8649
510 Thomson Road, #18-00                             Fax: +65-256-2403
SLF Building, Singapore 298135                http://www.ericsson.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
