Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbTFVLTs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTFVLTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:19:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42188
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264861AbTFVLTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:19:47 -0400
Subject: Re: gcc 3.3: largest *and* smallest kernels (was Re: [PATCH]
	Isapnp warning)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, cw@f00f.org,
       Linus Torvalds <torvalds@transmeta.com>, geert@linux-m68k.org,
       perex@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030622053909.GA5044@ip68-101-124-193.oc.oc.cox.net>
References: <20030621125111.0bb3dc1c.akpm@digeo.com>
	 <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com>
	 <20030622001101.GB10801@conectiva.com.br>
	 <20030622014102.GB29661@dingdong.cryptoapps.com>
	 <20030622014345.GD10801@conectiva.com.br>
	 <20030621191705.3c1dbb16.akpm@digeo.com>
	 <20030622053909.GA5044@ip68-101-124-193.oc.oc.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056281475.2075.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2003 12:31:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-22 at 06:39, Barry K. Nathan wrote:
> On Sat, Jun 21, 2003 at 07:17:05PM -0700, Andrew Morton wrote:
> > Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and produces a
> > kernel which is 200k larger.
> > 
> > It is simply worthless.
> 
> gcc 2.95.3 does compile faster than 3.3, but I don't think 3.3 is simply
> worthless:

With 2.95 people did benchmarks a long time back and -Os was outperforming
-O2 on some platforms at least. I'd bet the same is true with 3.3 on a
celeron too

