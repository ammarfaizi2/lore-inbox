Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133009AbREEQ60>; Sat, 5 May 2001 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbREEQ6Q>; Sat, 5 May 2001 12:58:16 -0400
Received: from bitmover.com ([207.181.251.162]:6476 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S133009AbREEQ6F>;
	Sat, 5 May 2001 12:58:05 -0400
Date: Sat, 5 May 2001 09:58:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: BitKeeper Development Source <dev@bitmover.com>
Subject: Wow! Is memory ever cheap!
Message-ID: <20010505095802.X12431@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	BitKeeper Development Source <dev@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 750Mhz K7 system with 1.5GB of memory in 3 512MB DIMMS.  The
DIMMS are not ECC, but we use BitKeeper here and it tells us when we
have bad DIMMS.

Guess what the memory cost?  $396.58 shipped to my door, second day air,
with a lifetime warranty.  I got it at www.memory4less.com which I found
using www.pricewatch.com.  I have no association with either of those
places other than being a customer (i.e., this isn't advertising spam).

I'm burning it in right now, I wrote a little program which fills it
with different test patterns and then reads them back to make sure they
don't lose any bits.  Seems to be working, it's done about 30 passes.

1.5GB for $400.  Amazing.  No more whining from you guys that BitKeeper
uses too much memory :-)

$ hinv
Main memory size: 1535.9375 Mbytes
1 AuthenticAMD  processor
1 1.44M floppy drive
1 vga+ graphics device
1 keyboard
IDE devices:
    /dev/hda is a ST310211A, 9541MB w/512kB Cache, CHS=1216/255/63
SCSI devices:
    /dev/sda is a 3ware disk, model 3w-xxxx 74.541 GB
PCI bus devices:
    Host bridge: VIA Technologies VT 82C691 Apollo Pro (rev 2).
    PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
    ISA bridge: VIA Technologies VT 82C686 Apollo Super (rev 34).
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 16).
    Host bridge: VIA Technologies VT 82C686 Apollo Super ACPI (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    RAID storage controller: Unknown vendor Unknown device (rev 18).
    VGA compatible controller: Matrox Matrox G200 AGP (rev 1).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
