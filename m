Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTJJN2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTJJN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:28:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39307 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262446AbTJJN2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:28:15 -0400
Date: Fri, 10 Oct 2003 14:27:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pascal Schmidt <der.eremit@email.de>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031010132756.GC28224@mail.shareable.org>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it> <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it> <DIAQ.2Hh.5@gated-at.bofh.it> <E1A6aWv-0000rJ-00@neptune.local> <Pine.LNX.4.53.0310061605001.733@chaos> <20031007104926.GA1659@openzaurus.ucw.cz> <Pine.LNX.4.53.0310100808360.2936@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0310100808360.2936@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > Since when is creating compatible hw called stealing?!
> 
> When the "compatible" device is a copy.

The gate-array or other binary-only firmware that is distributed
alongside an open source driver is not covered by an open source license.

(We may argue about the merits of that, but it is the de facto situation).

So you, as the owner of the firmware, have _strong_ copyright
protection against that firmware being used inappropriately.
That's the legal protection.

As for technical protection, if a clone product could make "a million
dollars", the cost of extracting firmware from a closed source driver
is trivial in comparison.  It takes a skilled coder minutes or hours;
nothing compared to the difficulty of making a clone board.

Contrarily, if you and the cloner are doing it all closed source, you
are not likely to know your firmware has been copied.  OTOH if it's
the norm to produce open source drivers, you can inspect your
competition's code to see if they ripped your firmware.  (They have to
release open source too, if it's the norm, because that's what's demanded).

The real issue is that when generic chips being used, some h/w
manufacturers aren't really making hardware.  They're putting a few
widely available chips together, and offering a design.  In effect
they are becoming software companies, and we already see how the
economics of that are changing world-wide.

> > If this was such a big problem, nothing prevents you
> > from putting ROM with those magic bits... How much is
> > that? _5?
> 
> Yes it does. Market pressure. The ROM may cost US$0.50.
> During the lifetime of the product, that may mean over
> a million dollars in lost profit. And, if you were a
> stockholder, you would not like that. Or, if you
> were an employee who lost his job because the company
> couldn't quite make up the cost of your salary. Every
> dime saved in the production cost of a high-volume product
> means several jobs saved.

It is relative; the million isn't important, if you made a billion
from the product.  It's far more important to asses how the $0.50
affects your margin.  On a device costing $15 to manufacture, it
depends on whether you are selling the device to the reseller for $16
or $50.

-- Jamie
