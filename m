Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132170AbQKSDEJ>; Sat, 18 Nov 2000 22:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbQKSDDt>; Sat, 18 Nov 2000 22:03:49 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:45064
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132170AbQKSDDs>; Sat, 18 Nov 2000 22:03:48 -0500
Date: Sat, 18 Nov 2000 18:33:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: PPC test11-7 barfed
Message-ID: <Pine.LNX.4.10.10011181833080.18290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        -o vmlinux
arch/ppc/mm/mm.o: In function `map_page':
arch/ppc/mm/mm.o(.text+0xd90): undefined reference to `set_pgdir'
arch/ppc/mm/mm.o(.text+0xd90): relocation truncated to fit: R_PPC_REL24 set_pgdir

Will hunt in a bit.

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
