Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSLQSd1>; Tue, 17 Dec 2002 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLQSd1>; Tue, 17 Dec 2002 13:33:27 -0500
Received: from va.cs.wm.edu ([128.239.2.31]:50438 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S265266AbSLQSd0>;
	Tue, 17 Dec 2002 13:33:26 -0500
Date: Tue, 17 Dec 2002 13:41:24 -0500
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre1: cannot load af-packet as module on Athlon
Message-ID: <22920000.1040150484@chorus.cs.wm.edu>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# insmod /lib/modules/2.4.21-pre1/kernel/net/packet/af_packet.o
/lib/modules/2.4.21-pre1/kernel/net/packet/af_packet.o: unresolved symbol 
_mmx_memcpy
/lib/modules/2.4.21-pre1/kernel/net/packet/af_packet.o: unresolved symbol 
sk_run_filter

Kernel is compiled for an Athlon SMP.  Configuration available at 
http://www.cs.wm.edu/~lowekamp/tmp/2.4.21-pre1-modules

Bruce

