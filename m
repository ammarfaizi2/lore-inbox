Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135749AbRD2Lso>; Sun, 29 Apr 2001 07:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135750AbRD2Lse>; Sun, 29 Apr 2001 07:48:34 -0400
Received: from p3E9E2E76.dip.t-dialin.net ([62.158.46.118]:11012 "HELO
	spot.local") by vger.kernel.org with SMTP id <S135749AbRD2LsX>;
	Sun, 29 Apr 2001 07:48:23 -0400
Date: Sun, 29 Apr 2001 13:48:49 +0200
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 - VIA PCI latency patch
Message-ID: <20010429134849.A5408@munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.4 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.4.4 the kernel says

PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA PCI latency patch.

on bootup. Is this the workaround for the 686B problems? I have a 686A board 
which should, in theory, be not affected by the bug. So why is this setting 
still applied? If it's something different, never mind.

Bye

Oliver


-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
