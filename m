Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbTFVCI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 22:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbTFVCI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 22:08:27 -0400
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:56328 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S265443AbTFVCI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 22:08:27 -0400
Date: Sat, 21 Jun 2003 21:27:59 -0500
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, torvalds@transmeta.com,
       geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622022759.GA30107@dingdong.cryptoapps.com>
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com> <20030622001101.GB10801@conectiva.com.br> <20030622014102.GB29661@dingdong.cryptoapps.com> <20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621191705.3c1dbb16.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 07:17:05PM -0700, Andrew Morton wrote:

> Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and
> produces a kernel which is 200k larger.

Do we know why this is the case?  I assume the fix is far from
trivial?

> It is simply worthless.

I stopped using 2.95.x recently because of miscompiles.  Even vendor
compilers seemed to break at times :(

  --cw
