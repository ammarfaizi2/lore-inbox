Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289355AbSA3QH1>; Wed, 30 Jan 2002 11:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289354AbSA3QHP>; Wed, 30 Jan 2002 11:07:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59780 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289341AbSA3QFd>; Wed, 30 Jan 2002 11:05:33 -0500
Date: Wed, 30 Jan 2002 11:07:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: TCP/IP Speed
Message-ID: <Pine.LNX.3.95.1020130110350.15189A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I ping two linux machines on a private link, I get 0.1 ms delay.
When I send large TCP/IP stream data between them, I get almost
10 megabytes per second on a 100-base link. Wonderful.

However, if I send 64 bytes from one machine and send it back, simple
TCP/IP strean connection, it takes 1 millisecond to get it back? There
seems to be some artifical delay somewhere.  How do I turn this OFF?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


