Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRFEMxG>; Tue, 5 Jun 2001 08:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbRFEMw4>; Tue, 5 Jun 2001 08:52:56 -0400
Received: from web14706.mail.yahoo.com ([216.136.224.123]:36104 "HELO
	web14706.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261651AbRFEMwt>; Tue, 5 Jun 2001 08:52:49 -0400
Message-ID: <20010605125244.32650.qmail@web14706.mail.yahoo.com>
Date: Tue, 5 Jun 2001 05:52:44 -0700 (PDT)
From: 753 user <user753@yahoo.com>
Subject: IRQ conflicts
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>With 2.4.5 I *often* get kernel Oopses with IRQ
>routing error messages. This never happend before
>and the only one change was a a second network
>card inserted into the mobo and changed kernel
>from 2.4.3 to 2.4.5.

As as wrote... Here is one of them, getting every 3
hours...

CPU: 0
EIP: 0010:[<c018a302>]
EFLAGS: 00010202
eax: c233cae0   ebx: 00001025   ecx: 00000000   edx:
00001025
esi: c21334a0   edi: c233c380   ebp: 00000060   esp:
c01fdddc
ds: 0018        es: 0018        ss: 0018
Process swapper (pid: 0, stackpage=c01fd000)
Stack: ...
Call Trace: ...
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0
74 09
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
