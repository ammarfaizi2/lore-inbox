Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265414AbTFVB1H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbTFVB1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:27:07 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:59399 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S265414AbTFVB1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:27:06 -0400
Date: Sat, 21 Jun 2003 22:43:45 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622014345.GD10801@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Chris Wedgwood <cw@f00f.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com> <20030622001101.GB10801@conectiva.com.br> <20030622014102.GB29661@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622014102.GB29661@dingdong.cryptoapps.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 21, 2003 at 08:41:02PM -0500, Chris Wedgwood escreveu:
> On Sat, Jun 21, 2003 at 09:11:01PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > Humm, I'd love to do that, i.e. to make gcc 3 required, lots of good
> > stuff like this one, anonymous structs, etc, etc, lots of stuff
> > could be done in an easier way, but are we ready to abandon gcc
> > 2.95.*? Can anyone confirm if gcc 2.96 accepts this?
> 
> What *requires* 2.96 still?  Is it a large number of people or obscure
> architecture?

I don't know, I was just trying to figure out the impact of requiring gcc 3
to compile the kernel. I never used gcc 2.96 btw.

- Arnaldo
