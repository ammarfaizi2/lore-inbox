Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbRCCB43>; Fri, 2 Mar 2001 20:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbRCCB4L>; Fri, 2 Mar 2001 20:56:11 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:25297 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S130225AbRCCBz6>; Fri, 2 Mar 2001 20:55:58 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B74779718809C6@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: kmod error
Date: Fri, 2 Mar 2001 20:55:37 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I built a 2.4.0 kernel and installed th bzImage in boot, configured
in lilo, etc. I also upgraded my modutils to 2.4.3. After that
when I tried to boot from the new kernel, I am getting
the following error message continuously.

kmod: failed to exec /sbin/modprobe -s -l binfmt-464c, errno = 8.

Is there any other package in addition to modutils, that also
needs upgrade ? or is there anything wrong with the image ?

Any help is appreciated.

-hiren
