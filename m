Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTJOLmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTJOLmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 07:42:05 -0400
Received: from smtp3.pp.htv.fi ([213.243.153.173]:26253 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262791AbTJOLmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 07:42:02 -0400
Message-ID: <1066218121.3f8d32897f51b@webmail.welho.com>
Date: Wed, 15 Oct 2003 14:42:01 +0300
From: tapiov@welho.com
To: linux-kernel@vger.kernel.org
Cc: tapiov@welho.com
Subject: 2.6.0-test7 : S3 Virge (DX) driver, framebuffer 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 207.83.32.85
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have an older PC, dating back to 1997, which has a graphic chip integrated on
the mother board. The chip is (based on) S3 Virge DX2. I have been using a
2.4.22 kernel from Slackware 9.1 distribution, which has been able to use the
framebuffer  modes (especially mode vga=773) successfully. 
So I tried compiling the 2.6.0-test7 kernel and followed the advice given in the
Framebuffer-HOWTO from TLDP (http://www.tldp.org/HOWTO/Framebuffer-HOWTO-5.html)
as good as I was able to. I could not find all the items from the xconfig menus
mentioned in that article  (namely the "advanced low level drivers) so I assumed
that the article was probably a bit outdated. I successfully turned on all
framebuffer related switches, fonts and mode selection support. Then compiled
and installed the new kernel. 

Now I found out that I wasn't able to use vga=773 anymore; only some
lower-resolution modes were available at the lilo prompt. From the mentioned
article I also read about a patch used earlier for S3 drivers, due to S3 chips
non-compatibility with VESA 2.0 (them being 1.2 only?).

Does such a patch exist still for 2.6.0? Or how could I get back to using better
resolution?

My apologizes, if this mail is completely off-topic. Please, let me know (email
me directly) if you have a better source of information than this forum.

Thanks,

Tapio Valli


