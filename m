Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTJJMNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTJJMNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:13:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55168 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261592AbTJJMNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:13:37 -0400
Date: Fri, 10 Oct 2003 08:14:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <20031007104926.GA1659@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.53.0310100808360.2936@chaos>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it>
 <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it>
 <DIAQ.2Hh.5@gated-at.bofh.it> <E1A6aWv-0000rJ-00@neptune.local>
 <Pine.LNX.4.53.0310061605001.733@chaos> <20031007104926.GA1659@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Pavel Machek wrote:

> Hi!
>
> > A company makes a new device that could run under Linux.
> > This device uses some standard gate-arrays. Because of
> > this, some gate-array bits need to be loaded upon startup.
> >
> > The company knows that if the competition learns that a
> > gate-array was used, instead of an ASIC, the competition
> > could clone the whole device in a few weeks, thereby
> > stealing a few million dollars of development effort.
>
>
> Since when is creating compatible hw called stealing?!

When the "compatible" device is a copy.

> If this was such a big problem, nothing prevents you
> from putting ROM with those magic bits... How much is
> that? _5?

Yes it does. Market pressure. The ROM may cost US$0.50.
During the lifetime of the product, that may mean over
a million dollars in lost profit. And, if you were a
stockholder, you would not like that. Or, if you
were an employee who lost his job because the company
couldn't quite make up the cost of your salary. Every
dime saved in the production cost of a high-volume product
means several jobs saved.

> --
> 				Pavel
> Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


