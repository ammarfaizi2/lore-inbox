Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132091AbRA0IjM>; Sat, 27 Jan 2001 03:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132166AbRA0IjC>; Sat, 27 Jan 2001 03:39:02 -0500
Received: from Huntington-Beach.blue-labs.org ([208.179.0.198]:53544 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132091AbRA0Iir>; Sat, 27 Jan 2001 03:38:47 -0500
Message-ID: <3A728911.E4A02068@linux.com>
Date: Sat, 27 Jan 2001 08:38:41 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: spurious IRQ complaints
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try
using pci=biosirq.

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        I/O ports at d000 [size=256]
        Memory at e9000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at e8000000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 1

Does it really need one?

-d


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
