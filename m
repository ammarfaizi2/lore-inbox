Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265278AbSJRSy4>; Fri, 18 Oct 2002 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265350AbSJRSv1>; Fri, 18 Oct 2002 14:51:27 -0400
Received: from f89.pav1.hotmail.com ([64.4.31.89]:20999 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265278AbSJRSpl>;
	Fri, 18 Oct 2002 14:45:41 -0400
X-Originating-IP: [193.153.111.132]
From: "Hermann =?ISO-8859-1?Q?K=E4ser=22?= <hermzz@hotmail.com>"@vax.home.local
To: linux-kernel@vger.kernel.org
Subject: Kernel panic! Unable to handle kernel NULL pointer dereference...
Date: Fri, 18 Oct 2002 18:51:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F89v91ySHW1HSAHwNKL00004d8c@hotmail.com>
X-OriginalArrivalTime: 18 Oct 2002 18:51:37.0685 (UTC) FILETIME=[635C8850:01C276D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic! Unable to handle kernel NULL pointer dereference

This happens during boot time after compiling latest stable kernel version 
2.4.19

kernel-2.4.19, boot, kernel panic

2.4.19

printing eip:
c02037aa
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c02037aa>]  Not tainted
EFLAGS: 00010282
eax: 00000000  ebx: c02037aa  ecx: c116b380  edx: c116b384
esi: c0372894 edi: c7fd82e4  ebp: 00000016  esp: c11ddef8
ds: 0018  es: 0018  ss: 0018
Process swapper: (pid:1, stackpage: c11dd0000)
Stack: c01cf344 c031ffe0 c0430008 c0430114 c7fd8314 c7fds2e4 00000001 
00000282
00000001 00000001 c0119ccb c037cce1 00000246 c0119bdd c031f102 c031f1bd
c7fd8200 c0430008 c01fc72b c031ebec c0430008 c1181437 c031f2e0 c7fd8200
Call Trace: [<c01ff394>] [<c0119ccb>] [<c0119bdd>] [<c01fc72b>] [<c01fc204>] 
[<c01fccca>] [<c01ff394>] [<c0105079>] [<c0107044>]
Code: 8b 40 20 c7 40 24 00 00 00 00 a1 80 24 37 c0 a3 88 22 43 c0
<0> Kernel panic: Attempted to kill init!

Software: Linux Debian

Processor Info: Pentium III Celeron (Coppermine)




_________________________________________________________________
Broadband? Dial-up? Get reliable MSN Internet Access. 
http://resourcecenter.msn.com/access/plans/default.asp

