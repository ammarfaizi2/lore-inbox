Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131828AbQKJV0g>; Fri, 10 Nov 2000 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbQKJV00>; Fri, 10 Nov 2000 16:26:26 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20939 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S131799AbQKJV0H>;
	Fri, 10 Nov 2000 16:26:07 -0500
Date: Fri, 10 Nov 2000 13:25:51 -0800
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The IrDA patches !!! (was Re: [RANT] Linux-IrDA status)
Message-ID: <20001110132551.K26405@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20001109192404.B25828@bougret.hpl.hp.com> <Pine.LNX.4.10.10011101143330.990-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.10.10011101143330.990-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 10, 2000 at 11:56:57AM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 11:56:57AM -0800, Linus Torvalds wrote:
> 
> When I say multiple mails, I mean multiple mails. NOT "26 attachements in
> one mail". In fact, not a single attachment at all, please. Send me
> patches as a regular text body, with the explanation at the top, and the
> patch just appended.

	No problem, they are going to come this way. Your mailbox
should be full by tonight.
	Please remember that they are *incremental*, skipping some of
them may work, skipping others may fail. I can't do much about that
because this is the way things are developped (patch of a patch).

> I can reply to it individually, and that patch (and nothing else) will be
> automatically set up for the reply so that I can easily quote whatever
> parts I want to point out.

	Good. I didn't know this featured existed ;-)

> You are WRONG.
> 
> 10 emails with 1000-line patches are _much_ easier to handle. I can
> clearly see the parts that belong together (nothing is mixed up with other
> issues), and I can keep the explanation in mind. I do not have to remind
> myself what that particular piece is doing.
> 
> It has other advantages too. With a single 10000-line patch, if I don't
> like something, I have a hard time just removing THAT part. So I have to
> reject the whole f*cking patch, and the person who sent it to me has to
> fix up the whole thing (assuming I'd bother answering to it, poitning out
> the parts that I don't like from the large patch, which I will not).
> 
> With 10 1000-line emails, I can decide to apply 8 of them outright, apply
> one with comments, and discard one that does something particularly
> nauseating. And I can much more easily explain to the submitter which one
> I hate, without having to edit it down.

	Yes, you are right, and I realised it looking back to some of
the patches. But this needs to be balanced against the cost of context
switches, especially for IrDA code.

> See?
> 
> 		Linus

	I hope you realise that I'm only acting as a facilitator and
doing the work of Dag, because I need to get IrDA in proper shape in
2.4 (because I need IrNET), and because most of the patches are mines
(see comments). So yes, I did flame, but it was only to get things
moving and remove the deadlock, so let's forget about the bad words...
	Dag will keep being the IrDA maintainer (I hope he will have
learned his lesson), and I hope you will finish the whole process with
Dag, because next week is a Wireless LAN week for me ;-) And I should
also look at BlueTooth PAN if ever I've got time :-(

	For the patches : I'll send them to you personally, there is
no need to abuse further the LKML (they have the attachement
version). They will be formated as described above. I hope my little
fingers won't do any mistakes ;-)

	Have fun, and thanks again for taking the time to sort out the
issues ;-)

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
