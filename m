Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbTLHKCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbTLHKCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:02:47 -0500
Received: from math.ut.ee ([193.40.5.125]:17084 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265359AbTLHKCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:02:46 -0500
Date: Mon, 8 Dec 2003 12:02:44 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23+BK: PPC compile error
Message-ID: <Pine.GSO.4.44.0312081201500.13502-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -I/home/mroos/compile/linux-2.4/arch/ppc   -c -o cpu_setup_6xx.o cpu_setup_6xx.S
cpu_setup_6xx.S: Assembler messages:
cpu_setup_6xx.S:164: Error: Unrecognized opcode: `andi'

32-bit PPC, Debian unstable (up to date). Compiling for PReP.

-- 
Meelis Roos (mroos@linux.ee)

