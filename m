Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130810AbRAMJMP>; Sat, 13 Jan 2001 04:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbRAMJMF>; Sat, 13 Jan 2001 04:12:05 -0500
Received: from adsl-208-190-215-71.dsl.stlsmo.swbell.net ([208.190.215.71]:21764
	"EHLO brendan.swbell.net") by vger.kernel.org with ESMTP
	id <S130121AbRAMJLu>; Sat, 13 Jan 2001 04:11:50 -0500
Date: Sat, 13 Jan 2001 03:07:26 +0100
To: linux-kernel@vger.kernel.org
Subject: Keyboard lock
Message-ID: <20010113030726.A325@q3test.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: Brendan D-G <brendan@q3test.2y.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a keyboard lock whenever anything tries to access the PS/2 port.
This topic seems to have been discussed back in March (http://www.uwsg.indiana.edu/hypermail/linux/kernel/0003.2/0097.html), but the only helpful information that came out of it was "change the IRQs in the BIOS", which my BIOS doesn't seem to be able to handle...

Kernel 2.4.0
Intel 440BX motherboard

I hope someone can help me with this, 2 button serial mice suck...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
