Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132236AbQKSD43>; Sat, 18 Nov 2000 22:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132272AbQKSD4T>; Sat, 18 Nov 2000 22:56:19 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:12560 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132236AbQKSD4I>;
	Sat, 18 Nov 2000 22:56:08 -0500
Date: Sat, 18 Nov 2000 20:24:46 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC test11-7 barfed
Message-ID: <20001118202446.E7211@hq.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.10.10011181833080.18290-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.10.10011181833080.18290-100000@master.linux-ide.org>; from Andre Hedrick on Sat, Nov 18, 2000 at 06:33:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grab the version at www.fsmlabs.com/linuxppcbk.html, it's fixed.  Linus
hasn't absorbed out updates in a while.  I'll feed him a bit more this
evening...

}         -o vmlinux
} arch/ppc/mm/mm.o: In function `map_page':
} arch/ppc/mm/mm.o(.text+0xd90): undefined reference to `set_pgdir'
} arch/ppc/mm/mm.o(.text+0xd90): relocation truncated to fit: R_PPC_REL24 set_pgdir
} 
} Will hunt in a bit.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
