Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSEEJyy>; Sun, 5 May 2002 05:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSEEJyx>; Sun, 5 May 2002 05:54:53 -0400
Received: from [212.159.14.223] ([212.159.14.223]:27901 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S290797AbSEEJyx>; Sun, 5 May 2002 05:54:53 -0400
Date: Sat, 4 May 2002 23:49:08 +0100
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.x keyboard oddities
Message-Id: <20020504234908.39e71442.jpm@it-he.org>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other day I finally got a 2.5 kernel (2.5.13) to compile and boot.
One of the major stumbling (crashing) blocks seems to be DEVFS, so I
simply disabled it and booted the kernel.

The system appears to have come up completely now, except for the
keyboard which is totally frozen throughout the entire boot process.

I don't have another PC but I might try and get my Psion Series 5
to act as a VT100 terminal and go in through serial.

The keyboard is a bog-standard AT 102 keyboard, attached through a
AT/PS2 converter to an ABIT KT133 ATX motherboard.. no USB stuff.
Keyboard is turned on in the input devices option in kernel config.
But it's utterly dead: even ALT-SYSRQ-B.  Is this normal?

-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  doug@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
