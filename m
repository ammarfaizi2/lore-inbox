Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTJGKqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJGKqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 06:46:44 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19978 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262131AbTJGKpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 06:45:04 -0400
Date: Tue, 7 Oct 2003 12:44:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andre Hedrick <andre@linux-ide.org>
cc: David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <Pine.LNX.4.10.10310070322520.2266-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0310071240530.17548-100000@serv>
References: <Pine.LNX.4.10.10310070322520.2266-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 Oct 2003, Andre Hedrick wrote:

> You got my point exactly, keep the issue of license to GPL and not muddy
> the waters with a license other than GPL as an example.

Fine, but you didn't answer my questions at all and you're the one 
complaining about EXPORT_SYMBOL_GPL in first place, so here are the 
questions again, in case you deleted the original mail already:

Could you please explain about what "added restrictions" you're talking 
about? Let's actually look at the GPL, which states "You may not impose 
any further restrictions on the recipients' exercise of the rights granted 
herein.", a bit earlier we find "Activities other than copying, 
distribution and modification are not covered by this License".
So how exactly does EXPORT_SYMBOL_GPL restrict you in these activities?

bye, Roman

