Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbTAUGI2>; Tue, 21 Jan 2003 01:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbTAUGI2>; Tue, 21 Jan 2003 01:08:28 -0500
Received: from samar.sasken.com ([164.164.56.2]:14826 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S265108AbTAUGI0>;
	Tue, 21 Jan 2003 01:08:26 -0500
Date: Tue, 21 Jan 2003 11:47:23 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel debugger
Message-ID: <Pine.LNX.4.33.0301211141580.8730-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am currently testing a device driver on linux-2.4.19. This is
implemented as a loadable kernel module.

# Could anyone suggest a good debugger that can be used to debug kernel
  modules?

# When I tried using gdb with vmlinux and /proc/kcore, I am getting a
  message saying that no debug symbols are found. How do I enable debug
  symbols for linux kernel image? Kernel Debug is already enabled. Is
  there some other configuration that needs to be there?

Thanks in advance.

regards
Madhavi.

