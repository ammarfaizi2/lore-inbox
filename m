Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQKLDNW>; Sat, 11 Nov 2000 22:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129905AbQKLDNN>; Sat, 11 Nov 2000 22:13:13 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:28671 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S129823AbQKLDMy>;
	Sat, 11 Nov 2000 22:12:54 -0500
Date: Sat, 11 Nov 2000 19:12:46 -0800
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@fast.no>
Subject: Re: The IrDA patches !!! (was Re: [RANT] Linux-IrDA status)
Message-ID: <20001111191246.D27826@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20001110132551.K26405@bougret.hpl.hp.com> <Pine.LNX.4.10.10011111842470.3611-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.10.10011111842470.3611-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 11, 2000 at 06:43:26PM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 06:43:26PM -0800, Linus Torvalds wrote:
> 
> 
> Ok, thanks to the work of Jean, everything seems to be applied now.
> 
> I'll make a test3 one of these days (probably tomorrow), please verify
> that everything looks happy.
> 
> 		Linus

	Linus,

	Sorry to bother you again, but a important note...
	I sent you the whole serie of patches. Then Dag sent it to you
again today. The patches were the same *except* for #14. Dag did
replace the original #14 patch that you didn't like with a cleaner
version (using empty packet to trigger speed changes).
	I'm sorry for the confusion. But don't worry, we will adjust
for whatever you put in test3 and work from there, so please don't do
anything ;-) And yes, I'll put it to the usual tests...

	And thanks again for taking the time to go through the patches
so quickly. We do appreciate your great work ;-)

	Have fun ;-)

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
