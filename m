Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319094AbSHMSQA>; Tue, 13 Aug 2002 14:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319061AbSHMSQA>; Tue, 13 Aug 2002 14:16:00 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.98]:45777 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S319094AbSHMSP6>; Tue, 13 Aug 2002 14:15:58 -0400
Message-Id: <200208131818.g7DIIgf321912@pimout5-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 13 Aug 2002 09:18:36 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Phillips <phillips@arcor.de>,
       Larry McVoy <lm@bitmover.com>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0208131425500.23404-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208131425500.23404-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 August 2002 01:29 pm, Rik van Riel wrote:
> On Tue, 13 Aug 2002, Linus Torvalds wrote:
> > Also, a license is a two-way street. I do not think it is morally right
> > to change an _existing_ license for any other reason than the fact that
> > it has some technical legal problem.
>
> Agreed, but we might be running into one of these.
>
> > I don't like patents. But I absolutely _hate_ people who play politics
> > with other peoples code. Be up-front, not sneaky after-the-fact.
>
> Suppose somebody sends you a patch which implements a nice
> algorithm that just happens to be patented by that same
> somebody.  You don't know about the patent.

That would be entrapment.  When they submit the patch, they're giving you an 
implied license to use it, even if they don't SAY so, just because they 
voluntarily submitted it and can't claim to be surpised it was then used, or 
that they didn't want it to be.  You could put up a heck of a defense in 
court on that one.

It's people who submit patches that use OTHER people's patents you have to 
worry about, and that's something you just can't filter for with the patent 
numbers rapidly approaching what, eight digits?

> Having a license that explicitly states that people who
> contribute and use Linux shouldn't sue you over it might
> prevent some problems.

Such a clause is what IBM insisted on having in ITS open source license.  You 
sue, your rights under this license terminate, which is basically automatic 
grounds for a countersuit for infringement.

(IBM has a lot of lawyers, and they pay them a lot of money.  It's 
conceivable they may actually have a point from time to time... :)

> regards,
>
> Rik

Rob
