Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRALOEY>; Fri, 12 Jan 2001 09:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131650AbRALOEE>; Fri, 12 Jan 2001 09:04:04 -0500
Received: from smtp1.libero.it ([193.70.192.51]:8616 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S131386AbRALOD5>;
	Fri, 12 Jan 2001 09:03:57 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Fri, 12 Jan 2001 15:00:14 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: dep <dennispowell@earthlink.net>
In-Reply-To: <Pine.NEB.4.31.0101112024250.9238-100000@neptun.fachschaften.tu-muenchen.de> <01011200182200.00925@af> <01011120083704.00618@depoffice.localdomain>
In-Reply-To: <01011120083704.00618@depoffice.localdomain>
Subject: Re: 2.4.0 Keyboard and mouse lock
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01011215001406.00925@af>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday 12 January 2001 02:08, you wrote:
> On Thursday 11 January 2001 06:18 pm, Andrea Ferraris wrote:
> | I don't know if it's the 2.4.0 I installed since few days, but
> | before I never seen that on my PC.
>
> strangely, same thing with 2.4.0 this afternoon. it was not unlike
> what we saw in test 12. /var/log/messages sheds no light, and BRB

What's BRB?

> fixed the instant problem. have been running 2.4.0 since it came out,
> and this was the first appearance of this problem.

The only thing that I didn't have before (2.2.17) in my syslog and that I 
seen in this /var/log/messages is that IRQ 9 is shared by eth realtek 
controller and the USB uhci one, but I don't know if that could be related
to lock. 

Another thing (related, unrelated?) is that sometimes since the install of 
the new kernel, after leaving the PC in stand by for some hours, when it 
unsuspends I have some pixels rows at the top of the screen green.

Boh?

	Regards,
			Andrea 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
