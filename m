Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUJIEzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUJIEzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 00:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUJIEzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 00:55:44 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:55442 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266474AbUJIEzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 00:55:42 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A647234@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc4 Oops: machine check, sig: 7 [#1]
Date: Sat, 9 Oct 2004 00:55:38 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# uname -a
Linux 192.168.0.5 2.6.8-rc4 #6 Wed Sep 29 13:33:22 EDT 2004 ppc unknown

# reboot

The system is going down NOW !!
Sending SIGKILL to all processes.
Please stand by while rebooting the system.
Restarting systemsteMachine check in kernel mode.
Caused by (from SRR1=41000): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
PREEMPT
NIP: FF000104 LR: FF000104 SP: C1A25E00 REGS: c1a25d50 TRAP: 0200    Not
tainted
MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c1b9f890[1] 'init' THREAD: c1a24000Last syscall: 162
GPR00: 00001032 C1A25E00 C1B9F890 001EF90C FF000104 00001002 000037D4
F00000A0
GPR08: 00000013 C0012E30 0000C000 00100088 0000000D 10063E5C 02000000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 01FFA834 00000000 00000003
01BCE2A0
GPR24: 00000000 10041550 7FFFFE68 10060000 00000000 00000000 FF000104
00000000
Call trace:
