Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSLBVvr>; Mon, 2 Dec 2002 16:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSLBVvr>; Mon, 2 Dec 2002 16:51:47 -0500
Received: from snow.ball.teaser.net ([213.91.6.13]:7173 "EHLO
	snow.ball.reliam.net") by vger.kernel.org with ESMTP
	id <S265051AbSLBVvq>; Mon, 2 Dec 2002 16:51:46 -0500
Date: Mon, 2 Dec 2002 22:57:28 +0100
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <9814769328.20021202225728@uni.de>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
In-Reply-To: <Pine.LNX.4.44.0212022051320.20834-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212022051320.20834-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

Monday, December 2, 2002, 10:07:33 PM, you wrote:


JS> Hi!

JS> I have a new patch avaiable. It is against 2.5.50. The patch is at
JS> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

JS> [...]
JS> The diffstat is:

JS>  CREDITS                                |   10 

Hunk #1 succeeded at 2836 (offset -6 lines).

JS>  [...]
JS>  arch/i386/vmlinux.lds.s                |  114
               ^^^^^^^^^^^^^^
really intended?

JS>  [...]
JS>  drivers/char/tty_io.c                  |    7

Hunk #1 succeeded at 1503 (offset -6 lines).

JS>  [...]
JS>  drivers/video/Kconfig                  |  411 --

Hunk #19 succeeded at 864 with fuzz 1 (offset -7 lines).

(of course against 2.5.50 vanilla)
--
cheers,
 Tobias

