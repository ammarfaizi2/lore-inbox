Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130797AbRAMSYt>; Sat, 13 Jan 2001 13:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRAMSYk>; Sat, 13 Jan 2001 13:24:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130537AbRAMSY3>;
	Sat, 13 Jan 2001 13:24:29 -0500
Date: Sat, 13 Jan 2001 19:24:31 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: PS/2 mouse access kills keyboard
Message-ID: <Pine.LNX.4.21.0101131922260.19338-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

on plain 2.4.0 vanilla any mouse access kills the keyboard. Only way to
restore functionality is to kill gpm.

gpm writes 'protocol error' to syslog. I have access to this machine on
monday, so I can post details then.

Changing the IRQ is totally unrelated, machine works in 2.2.x with the
same config.


	regards,

		
		Igmar


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
