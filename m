Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286356AbRL0RD1>; Thu, 27 Dec 2001 12:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286361AbRL0RDR>; Thu, 27 Dec 2001 12:03:17 -0500
Received: from dns.logatique.fr ([213.41.101.1]:31477 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S286360AbRL0RDD>; Thu, 27 Dec 2001 12:03:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, riel@conectiva.com.br (Rik van Riel)
Subject: Re: The direction linux is taking
Date: Thu, 27 Dec 2001 18:03:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16Jdme-00065I-00@the-village.bc.nu>
In-Reply-To: <E16Jdme-00065I-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011227170036.70F1E23CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > I don't care about Linus, he drops so many bugfixes
> > his kernel have done nothing but suck rocks since the
> > 2.1 era.
> >
> > This system could be useful for people who _are_ maintainers,
> > however.
>
> In which case you'll find jitterbug on www.samba.org



I disagree, jitterbug is cool, but it doesn't handle all the points Rik have 
asked for. Especially point 3 : check that each patch apply and if not, send 
a mail to the maintainer. Or points 4,5, ...

It shouldn't be difficult to write such a system, though. The problem is : 
would that kind of system be used. I don't even ask about Linus : I know he 
won't.


	What about Marcelo, Alan and the main-kernel-part maintainers ?


Marcello, Alan, tell us you would use such a system, and I'm sure people 
would try to setup something.
Too much people have actually spent time on developping tools especially for 
the linux kernel. Tell us you'll use such a system, and we'll write/hack it.
You remember Linus saying he'll integrate kbuild and cml2 between 2.5.1 and 
2.5.2 ? Do you still believe this ? I don't.

And, btw, jitterbug is too big for Linus. He's afraid of too complex system. 
IMHO he could consider using a small&simple tool that fit exactly his view of 
what kernel development is.
That is : how it's done today, but automaticated.
"he could". But how to know ? no way, no way. 

regards,
Thomas


> > I don't care about Linus, he drops so many bugfixes
> > his kernel have done nothing but suck rocks since the
> > 2.1 era.
> >
> > This system could be useful for people who _are_ maintainers,
> > however.
>
> In which case you'll find jitterbug on www.samba.org

system, and I'm sure people would try to setup something.
Too much people have actually spent time on developping tools especially for 
the linux kernel. Tell us you'll use such a system, and we'll write/hack it.

You remember Linus saying he'll integrate kbuild and cml2 between 2.5.1 and 
2.5.2 ? Do you still believe this ? I don't.

And, btw, jitterbug is too big for Linus. He's afraid of too complex system. 
IMHO he could consider using a small&simple tool that fit exactly his view of 
what kernel development is.
That is : how it's done today, but automaticated.

regards,
Thomas
