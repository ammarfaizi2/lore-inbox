Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSHaOSy>; Sat, 31 Aug 2002 10:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSHaOSy>; Sat, 31 Aug 2002 10:18:54 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:44817 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S315430AbSHaOSx>; Sat, 31 Aug 2002 10:18:53 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208311418.g7VEImGD004866@wildsau.idv.uni.linz.at>
Subject: 2.4.19, CONFIG_RAMFS=y
To: linux-kernel@vger.kernel.org (l)
Date: Sat, 31 Aug 2002 16:18:48 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

in <linus/fs/Config.in>, RAMFS is defined y always. why not make it
a tristate? the help says, that RAMFS is a programming example only,
so there's no need to absolutely have it compiled in the kernel.

thanks,
h.rosmanith
