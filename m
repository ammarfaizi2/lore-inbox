Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTJBJim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 05:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTJBJim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 05:38:42 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:56848 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262420AbTJBJil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 05:38:41 -0400
Date: Thu, 2 Oct 2003 06:44:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHES] today's batch of "nuking kernel/ksyms.c"
Message-ID: <20031002094459.GD1699@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031002030338.GB1699@conectiva.com.br> <20031002040206.GA2382@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002040206.GA2382@work.bitmover.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 01, 2003 at 09:02:06PM -0700, Larry McVoy escreveu:
> If this is all the same idea why are you putting it in multiple changesets?
> Where I work we have a rule "one idea, one changeset", which makes it far
> easier to track down problems later.

Oh well, I thought it was better to slowly deconstruct the thing, started
sending, my feedback was that the trees are being pulled by Linus, so
everything seems to be allright, if Linus merged all of micro changesets as one
changeset I'd understand that as "stop sending as separate changesets, send me
just one", and I'd do just that, Linus?

- Arnaldo
