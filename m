Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSKRVFJ>; Mon, 18 Nov 2002 16:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSKRVFJ>; Mon, 18 Nov 2002 16:05:09 -0500
Received: from ohmsc.com ([200.75.37.242]:28544 "EHLO ohmsc.com")
	by vger.kernel.org with ESMTP id <S264779AbSKRVFI> convert rfc822-to-8bit;
	Mon, 18 Nov 2002 16:05:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: =?utf-8?q?Andr=C3=A9s=20Su=C3=A1rez?= <webmaster@colservers.com>
Organization: Colservers Hosting de Colombia
To: linux-kernel@vger.kernel.org
Subject: Kernel errors
Date: Mon, 18 Nov 2002 16:15:08 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211181615.08148.webmaster@colservers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Someone could me explain this kernel errors?

****************************
Nov 18 12:34:20 linux kernel: Unable to handle kernel paging request at
virtual address 70f379d3
Nov 18 12:34:20 linux kernel:  printing eip:
Nov 18 12:34:20 linux kernel: c0120189
Nov 18 12:34:20 linux kernel: *pde = 00000000
Nov 18 12:34:20 linux kernel: Oops: 0000
Nov 18 12:34:20 linux kernel: CPU:    0
Nov 18 12:34:20 linux kernel: EIP:    0010:[<c0120189>]    Not tainted
Nov 18 12:34:20 linux kernel: EFLAGS: 00010202
Nov 18 12:34:20 linux kernel: eax: 70f379cb   ebx: d5fd8b30   ecx: 00000011
edx: 0001f06b
Nov 18 12:34:20 linux kernel: esi: 000000a6   edi: 000000bb   ebp: c18fc1ac
esp: d9d69ed0
Nov 18 12:34:20 linux kernel: ds: 0018   es: 0018   ss: 0018
Nov 18 12:34:20 linux kernel: Process ipop3d (pid: 30184,
stackpage=d9d69000)
Nov 18 12:34:20 linux kernel: Stack: dd1cd0c0 00000015 000000a6 dd1cd0c0
00000020 c0120735 0000001f 0000011a
Nov 18 12:34:20 linux kernel:        c18fc0dc c13eb9c0 d5fd8b30 00000087
c0120988 00000001 dd1cd0c0 d5fd8a80
Nov 18 12:34:20 linux kernel:        c13eb9c0 00001000 00000001 00000000
00000000 d5fd8a80 dd06484c df934a0e
Nov 18 12:34:20 linux kernel: Call Trace: [<c0120735>] [<c0120988>]
[<e08d7db2>] [<c0120e8a>] [<c0120db0>]
Nov 18 12:34:20 linux kernel:    [<c012c305>] [<c012bfd0>] [<c012c17e>]
[<c0106cfb>]
Nov 18 12:34:20 linux kernel:
Nov 18 12:34:20 linux kernel: Code: 39 58 08 75 f4 39 78 0c 75 ef 85 c0 75
4a 8b 43 30 31 d2 e8
******************************************


Thanks,

Andres Suarez

