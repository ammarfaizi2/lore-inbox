Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTFVBVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265414AbTFVBVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:21:38 -0400
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:49672 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S265403AbTFVBVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:21:30 -0400
Date: Sat, 21 Jun 2003 20:41:02 -0500
From: Chris Wedgwood <cw@f00f.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622014102.GB29661@dingdong.cryptoapps.com>
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com> <20030622001101.GB10801@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622001101.GB10801@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 09:11:01PM -0300, Arnaldo Carvalho de Melo wrote:

> Humm, I'd love to do that, i.e. to make gcc 3 required, lots of good
> stuff like this one, anonymous structs, etc, etc, lots of stuff
> could be done in an easier way, but are we ready to abandon gcc
> 2.95.*? Can anyone confirm if gcc 2.96 accepts this?

What *requires* 2.96 still?  Is it a large number of people or obscure
architecture?


  --cw
