Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310514AbSCLKCP>; Tue, 12 Mar 2002 05:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310539AbSCLKCG>; Tue, 12 Mar 2002 05:02:06 -0500
Received: from mx0.gmx.net ([213.165.64.100]:23036 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S310514AbSCLKB4>;
	Tue, 12 Mar 2002 05:01:56 -0500
Date: Tue, 12 Mar 2002 11:01:50 +0100 (MET)
From: gjwucherpfennig@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Kernel panic with linux-2.5.6
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008922711@gmx.net
X-Authenticated-IP: [194.31.240.5]
Message-ID: <12613.1015927310@www7.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Kernel panic occured while compiling KDE cvs on an P2@300MHz


Unable to handle paging request at virtual adress: 63746157
*pde: 00000000
Oops: 0000
CPU: 0
EIP: 0010: [<c021a849>] Not tainted
EFLAGS: 00010296
eax: 63746157 ebx: 6c613974 ecx: 0000000a edx: 00000002
esi: cf69760c edi: efe76d60 ebp: 00000000 esp: c2273f0c
ds: 0018 es: 0018550018
Process cc1plus (pid 6145, threadinfo c2272000 task: ca57e700)
Stack: 63746157 00000000 00000001 6c613974 cf69760c ...
          ...
          ...
CallTrace: [<c021a9f9>] [<c021acfc>] [<c010850a>] [<c0108701>]
Code 86 18 86 40 04 f6 40 04 f6 40 de 80 74 12 86 54 24 28 85 d2 75 0a 68
<0> Kernel panic: Aicey killing interrupt handler!
In interrupt handler - not syncing

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

