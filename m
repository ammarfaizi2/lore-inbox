Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265927AbRFZHHm>; Tue, 26 Jun 2001 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265928AbRFZHHd>; Tue, 26 Jun 2001 03:07:33 -0400
Received: from node-c-0bd1.a2000.nl ([62.194.11.209]:32640 "EHLO
	globus.uptsoft.com") by vger.kernel.org with ESMTP
	id <S265927AbRFZHHP>; Tue, 26 Jun 2001 03:07:15 -0400
Date: Tue, 26 Jun 2001 09:07:08 +0200
From: Yarick <ysu@hetnet.nl>
To: linux-kernel@vger.kernel.org
Cc: support@epox.com
Subject: Possible timing problems after a bios upgrade.
Message-ID: <20010626090708.A3055@globus.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to a new bios (dated 06/14/2001) on EPOX EP-8KTA3+
motherboard I have the following problems:

- The SB128 PCI (module es1371) plays about twise slower than normal.
- The via UDMA shows about 15Mb/sec instead of ~35Mb/sec.

The text from the bios upgrade says:

 *  Fixed compatibility with nVidia Geforce 2 MX AGP card causing system hangs while running 3DMark2001.
 * Changed method to show AMD K7 CPU FSB.
 * DRAM Bank-Interleave will be disabled if VCM SPD ROM is bad (or fails).

The windows behaviour did not alter (at least I did not notice).

An ideas?

Best,
Yarick.

