Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282793AbRLKTuv>; Tue, 11 Dec 2001 14:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282799AbRLKTul>; Tue, 11 Dec 2001 14:50:41 -0500
Received: from corp.tivoli.com ([216.140.178.60]:5261 "EHLO corp.tivoli.com")
	by vger.kernel.org with ESMTP id <S282793AbRLKTu2>;
	Tue, 11 Dec 2001 14:50:28 -0500
Message-ID: <3C166540.DC0BDBEE@mail.com>
Date: Tue, 11 Dec 2001 13:57:52 -0600
From: Brian Horton <go_gators@mail.com>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: how to debug a deadlock'ed kernel?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone got any good tips on how to debug a SMP system that is locked up
in a deadlock situation in the kernel? I'm working on a kernel module,
and after some number of hours of stress testing, the box locks up. None
of the sysrq options show anything on the display, though the reBoot
option does reboot the system. RedHat 6.2 and its 2.2.14 kernel. Doesn't
hang for me on 2.4, so I need to debug it here... 

Any hints? 

thx.bri.
