Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRDCAIb>; Mon, 2 Apr 2001 20:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRDCAIV>; Mon, 2 Apr 2001 20:08:21 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:41159 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S129436AbRDCAIM>; Mon, 2 Apr 2001 20:08:12 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A00@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: vmalloc on 2.4.x on ia64
Date: Mon, 2 Apr 2001 20:07:26 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Is vmalloc() interface broken on any of 2.4.x kernel on ia64 ?
I am trying to call vmalloc from the driver to allocate
about 130kb of memory and it hangs the system.
I am running 2.4.1 kernel with ia64 patch (I can find out the
exact patch if needed) on LION. Let me know if more information
is required.

Thanks and regards,
-hiren
