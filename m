Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131807AbQKJVgH>; Fri, 10 Nov 2000 16:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131848AbQKJVf5>; Fri, 10 Nov 2000 16:35:57 -0500
Received: from [194.213.32.137] ([194.213.32.137]:16132 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131807AbQKJVfl>;
	Fri, 10 Nov 2000 16:35:41 -0500
Message-ID: <20001110222416.B300@bug.ucw.cz>
Date: Fri, 10 Nov 2000 22:24:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dag Brattli <dagb@fast.no>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [RANT] Linux-IrDA status
In-Reply-To: <Pine.LNX.4.10.10011072316180.15590-100000@penguin.transmeta.com> <200011081215.MAA69418@tepid.osl.fast.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200011081215.MAA69418@tepid.osl.fast.no>; from Dag Brattli on Wed, Nov 08, 2000 at 12:15:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Some options:
> 
> 1) Split up the large patch and fix the things you didn't like, submit them
> with better discription. But then It's probably to late anyway for 2.4 (even if 
> the 2.4-test series is not the most stable stuff I've tried). Is it
> to late for this?

Probably not. Get tytso to agree that broken IrDA is critical bug,
split patches, and see them accepted.

> 2) Remove IrDA from the kernel, and we'll go back to using CVS and 
> make our own package (like PCMCIA and IrDA was before they got 
> into the kernel. At least PCMCIA used to work back then ;-)

Do not do that, please.

> 3) Just apply the stuff!?! Look at Jean's mail for description of
> the changes.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
