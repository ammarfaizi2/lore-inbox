Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289042AbSA3KEH>; Wed, 30 Jan 2002 05:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289044AbSA3KDr>; Wed, 30 Jan 2002 05:03:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289042AbSA3KDn>; Wed, 30 Jan 2002 05:03:43 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 30 Jan 2002 10:14:49 +0000 (GMT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        viro@math.psu.edu (Alexander Viro), mingo@elte.hu (Ingo Molnar),
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org,
        riel@conectiva.com.br (Rik van Riel)
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 29, 2002 11:48:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VrlR-0006vL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How many other people are actually using bitkeeper already for the kernel?
> I know the ppc guys have, for a long time, but who else is? bk, unlike
> CVS, should at least be _able_ to handle a "network of people" kind of
> approach.

I gave up on CVS for internal stuff with the -ac patches. I ended up keeping
a running patch and a complete archive of the submissions. The archive so
I can ensure info gets back and forth neatly.

(tangientially further)

Larry - can bitkeeper easily be persuaded to take "messages" back all the way 
to the true originator of a change. Ie if a diff gets to Linus he can reject
a given piece of change and without passing messages back down the chain
ensure they get the reply as to why it was rejected, and even if
nobody filled anything in that it was looked at and rejected by xyz at
time/date ?
