Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbSJEOku>; Sat, 5 Oct 2002 10:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262353AbSJEOku>; Sat, 5 Oct 2002 10:40:50 -0400
Received: from toole.uol.com.br ([200.221.4.26]:57244 "EHLO toole.uol.com.br")
	by vger.kernel.org with ESMTP id <S262334AbSJEOkt>;
	Sat, 5 Oct 2002 10:40:49 -0400
Date: Sat, 5 Oct 2002 11:47:25 -0200
From: Andre Costa <brblueser@uol.com.br>
To: Linux kernel ML <linux-kernel@vger.kernel.org>
Subject: IDE subsystem issues with 2.4.1[89] [REVISITED]
Message-Id: <20021005114725.3af9c194.brblueser@uol.com.br>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

found this msg on kernel ML archives about 2.4.1[89] having probls with
CD audio ripping:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103364684525654&w=2

The poster (Dexter Filmore) has the very same mobo I have (MSI K7T266
Pro2, Athlon XP) and he's experiencing similar probls to the ones I am
experiencing (in my case, lock ups are temporary, don't know if it is
the same with him). Tried the same kernels here, on RH 7.1, using:

gcc-3.2-1
binutils-2.13-1
modutils-2.4.18-2

I know this is a known issue, and you guys are working on it; I also
know many changes to IDE subsystem have been backported from 2.5.x
series, and 2.4.20pre* already reflect some (all?) of them. I don't want
to rush things, I was just curious to know the current status regarding
these IDE issues.

If you need additional info about my system configuration or log
messages, just let me know and I will be happy to provide it.

TIA,

Andre

-- 
Andre Oliveira da Costa
