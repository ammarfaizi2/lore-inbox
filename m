Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbRABObH>; Tue, 2 Jan 2001 09:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRABOa5>; Tue, 2 Jan 2001 09:30:57 -0500
Received: from mplspop4.mpls.uswest.net ([204.147.80.14]:1031 "HELO
	mplspop4.mpls.uswest.net") by vger.kernel.org with SMTP
	id <S131136AbRABOai>; Tue, 2 Jan 2001 09:30:38 -0500
Date: Tue, 2 Jan 2001 07:56:26 -0600 (CST)
Message-ID: <Pine.LNX.4.30.0101020754330.28352-100000@localhost.localdomain>
From: "Nitebirdz" <nitebirdz@uswest.net>
To: "jim m." <msg124@hotmail.com>
Cc: redhat-install-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: system freeze question
In-Reply-To: <F1218N8yxdZjfNLnlyg0000a3ab@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2000,  jim m. wrote:

> hi,
> there are times when newly installed driver just freezes the
> RH6.2 and mouse cursor is rock solid frozen. ALT+PRTScreen+...
> does not work. I now for fact that ALT+PRT... works because
> i tested it. Anything else can be done to reboot the system
> graciously than "reset"?.  Any advice..
> J


Very rarely should tou need to hit the "Reset" button on a Linux/UNIX box.
You may want to try hitting Ctrl+Alt+F2 to go to an alternate console,
then logging in as root, and sending the "gpm" process a KILLHUP signal
for example.

------------------------------------------------------
Nitebirdz
------------------------------------------------------
"We all know Linux is great... it does infinite
loops in 5 seconds." (Linus Torvalds)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
