Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTJJIho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbTJJIho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:37:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20400 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262655AbTJJIhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:37:43 -0400
Date: Tue, 7 Oct 2003 12:49:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031007104926.GA1659@openzaurus.ucw.cz>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it> <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it> <DIAQ.2Hh.5@gated-at.bofh.it> <E1A6aWv-0000rJ-00@neptune.local> <Pine.LNX.4.53.0310061605001.733@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0310061605001.733@chaos>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A company makes a new device that could run under Linux.
> This device uses some standard gate-arrays. Because of
> this, some gate-array bits need to be loaded upon startup.
> 
> The company knows that if the competition learns that a
> gate-array was used, instead of an ASIC, the competition
> could clone the whole device in a few weeks, thereby
> stealing a few million dollars of development effort.


Since when is creating compatible hw called stealing?!
If this was such a big problem, nothing prevents you
from putting ROM with those magic bits... How much is
that? _5?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

