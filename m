Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314442AbSEBN5y>; Thu, 2 May 2002 09:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314443AbSEBN5x>; Thu, 2 May 2002 09:57:53 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:55794 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S314442AbSEBN5w>;
	Thu, 2 May 2002 09:57:52 -0400
Date: Thu, 2 May 2002 16:57:50 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre7: unresolved symbols in modules
Message-ID: <Pine.GSO.4.43.0205021652570.3223-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unresolved symbols from my custom configuration (x86, modular ide, many
debugging variables from kernel hacking section, many framebuffers):

ide-probe-mod:		ide_xlate_1024_hook
fbcon-cfb16:		__io_virt_debug
fbcon-cfb2:		__io_virt_debug
fbcon-cfb24:		__io_virt_debug
fbcon-cfb4:		__io_virt_debug
fbcon-cfb8:		__io_virt_debug
fbcon-hga:		__io_virt_debug
fbcon-mfb:		__io_virt_debug
fbcon-vga-planes:	__io_virt_debug
fbcon-vga:		__io_virt_debug
matroxfb_misc:		__io_virt_debug

---
Meelis Roos (mroos@linux.ee)

