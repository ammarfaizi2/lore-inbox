Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283035AbRK1NhA>; Wed, 28 Nov 2001 08:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283041AbRK1Ngv>; Wed, 28 Nov 2001 08:36:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:56204 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S283035AbRK1Ngg>; Wed, 28 Nov 2001 08:36:36 -0500
Date: Wed, 28 Nov 2001 08:36:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Magic Lantern
Message-ID: <Pine.LNX.3.95.1011128083018.10601A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there currently any kernel hooks to support Magic Lantern?
Basically, a "tee" to capture all network packets and pass them
on to a filtering task without affecting normal network activity.
It's like `tcpdump`, but allows packets to be inserted into the
output queue as well without affecting normal network activity.

Yes, I know a module could be written, but I wonder if the
capability already exists.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


