Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbTIOVkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTIOVkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:40:16 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:51091 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP id S261647AbTIOVkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:40:09 -0400
From: Marek Szyprowski <march@staszic.waw.pl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2003 23:34:23 +0100
Message-ID: <yam9388.1183.1193506560@boss.staszic.waw.pl>
In-Reply-To: <Pine.GSO.4.21.0309111730550.1879-100000@vervain.sonytel.be>
X-Mailer: YAM 2.4p1 [040] AmigaOS E-mail Client (c) 2000-2003 by YAM Open Source Team - http://www.yam.ch/
Subject: Re: ASFS filesystem patch, kernel 2.4.21
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert

On 11.09.03, you wrote:

>> This patch adds read-only support for Amiga SmartFileSystem. This
>> filesystem is being used very commonly on AmigaOS and MorphOS systems.
>> This patch has been tested on Linux/PPC, Linux/m68k and Linux/x86
>> machines. This patch is prepared for kernel 2.4.21.

> ASFS is happily living in the Linux/m68k CVS tree as well.

> However, I guess Marcelo will insist you port it to 2.6.0 first, before it
> will be accepted in the mainline.

OK. I made a quick port to 2.6.x. It compiles without any problems and even
works (I tested it on a 2.6.0test5/x86).

Both patches (for 2.4.x and 2.6.x) are available at:

http://www.staszic.waw.pl/~march/asfs/

Regards
-- 
Marek Szyprowski .. GG:2309080 .. mailto:marek@amiga.pl ..
...... happy AmigaOS, MacOS and Debian/Linux user ........
........... http://march.home.staszic.waw.pl/ ............

