Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281264AbRKLF6f>; Mon, 12 Nov 2001 00:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281266AbRKLF6Z>; Mon, 12 Nov 2001 00:58:25 -0500
Received: from ccs.covici.com ([209.249.181.196]:25472 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S281264AbRKLF6G>;
	Mon, 12 Nov 2001 00:58:06 -0500
To: linux-kernel@vger.kernel.org
Subject: what does no pin a mean?
From: John Covici <covici@ccs.covici.com>
Date: 12 Nov 2001 00:58:02 -0500
Message-ID: <m3itcg8r9x.fsf@ccs.covici.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.14 kernel and a Shuttle ak31a motherboard.

I am wondering what the log excerpt below means and what should I do
about it?

Thanks.

Nov 11 21:55:15 ccs kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov 11 21:55:15 ccs kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 11 21:55:15 ccs kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Nov 11 21:55:16 ccs kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
Nov 11 21:55:16 ccs kernel: VP_IDE: chipset revision 6
Nov 11 21:55:16 ccs kernel: VP_IDE: not 100%% native mode: will probe irqs later
Nov 11 21:55:16 ccs kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 11 21:55:16 ccs kernel: VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1

-- 
         John Covici
         covici@ccs.covici.com
