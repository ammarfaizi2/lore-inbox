Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131159AbQLMLdp>; Wed, 13 Dec 2000 06:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131161AbQLMLdf>; Wed, 13 Dec 2000 06:33:35 -0500
Received: from relay.inway.cz ([212.24.128.3]:15163 "EHLO tac.inway.cz")
	by vger.kernel.org with ESMTP id <S131159AbQLMLdY> convert rfc822-to-8bit;
	Wed, 13 Dec 2000 06:33:24 -0500
Message-ID: <000f01c064f4$157f3570$a49418d4@shredder>
From: "Petr Sebor" <petr@scssoft.com>
To: <linux-kernel@vger.kernel.org>
Cc: Martin Maèok <martin.macok@underground.cz>
In-Reply-To: <20001213105153.A6624@sarah.kolej.mff.cuni.cz>
Subject: Re: 2.4.0-test12 randomly hangs up
Date: Wed, 13 Dec 2000 12:01:46 +0100
Organization: SCS Software
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same here... this thing started to happen right after upgrading to test12 
(from test11). I am still being able to work on console for hours but when 
I start using X the system dies silently. No oops, keyboard inactive 
(can't do sysrq), and the LED on the monitor is orange, not green. This 
happens under almost no load at all even after a fresh start. I have plenty
of free memory, swap file not used at all.

Just a 'me too'

Regards,
Petr

----- Original Message ----- 
From: "Martin Macok" <martin.macok@underground.cz>
Newsgroups: linux.kernel
Sent: Wednesday, December 13, 2000 10:53 AM
Subject: 2.4.0-test12 randomly hangs up


> Hi,
> after 1-3 hours with -test12 system hangs up with
>  - no response from mouse
>  - no response from keyboard (no sysrq, only sysrq+'b' works ...)
>  - no response from network (ICMP, TCP)
>  - nothing on console, nothing in logs (ie. nothing interesting or relevant
>    to crash).
> 
> System was not under load (1 user, X, no swapping ...)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
