Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135652AbRDXOa2>; Tue, 24 Apr 2001 10:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135651AbRDXOaI>; Tue, 24 Apr 2001 10:30:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135641AbRDXOaE>; Tue, 24 Apr 2001 10:30:04 -0400
Subject: Re: [PATCH] Single user linux
To: imel96@trustix.co.id
Date: Tue, 24 Apr 2001 15:30:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104242105490.16290-100000@tessy.trustix.co.id> from "imel96@trustix.co.id" at Apr 24, 2001 09:10:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s3pr-0002B3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Even my digital tv box has multiple users. The fact you cannot figure out how
> > to make your UI present that to the end user in a suitable manner is not
> > the kernels problem. Get a real UI designer
> 
> if it's useful, it's okay. if not, what is it doing there?

For one it allowing you to build enough of a security model to prevent your
phone user from deleting critical system files by accident. Something 
incredibly basic that I cannot believe anyone could overlook

Take a look why my Digital TV has multiple users


	-	It can charge pay per view films to multiple accounts
		(think about multiple SIM cards)

	-	It remembers personal barriers (so I can require
		passwords to watch adult rated films for example)
		(For a phone think about call barring - set the phone user
		 and loan it for calls home only to children)

	-	It remembers preferences. (Currently only useful for junk
		sky interactive stuff like email)
		(think about multiple email accounts)

And it has a perfectly sane UI for all of this. In fact most people have 
probably never realised their set top box even has the concept of users in it
because they've never set more than one up.

Another reason your device needs good security models is that if I can't store
digital credit card data safely on it, its a dead product line soon. If it
can't do internet its an ex product.

How do you plan to do internet without a security model in your OS. How are you
going to protect credit card data from web browser bugs. How are you going to
protect that data from sms parsing bugs ?

How do you plan to deal with synchronizing data between multiple systems when
you have no user model ?

The questions you should be asking are not 'Why do I need a security model' they
are 'Is the model provided good enough'.

Alan

