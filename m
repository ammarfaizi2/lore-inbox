Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135526AbRAJNOp>; Wed, 10 Jan 2001 08:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135543AbRAJNOf>; Wed, 10 Jan 2001 08:14:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135526AbRAJNOY>; Wed, 10 Jan 2001 08:14:24 -0500
Date: Wed, 10 Jan 2001 08:14:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.0 (release) drops core upon login.
Message-ID: <Pine.LNX.3.95.1010110080935.19878A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

If an i686 SMP machine has sat idle for a period of time (overnight),
an attempt of log in will result in /sbin/login dropping core.
The getty is not affected. A subsequent login will succeed. This
occurs for each configured virtual terminal, i.e., Alt-F1 through Alt-F4.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
