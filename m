Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTBYGHF>; Tue, 25 Feb 2003 01:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267693AbTBYGHE>; Tue, 25 Feb 2003 01:07:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:49866 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267692AbTBYGHE>; Tue, 25 Feb 2003 01:07:04 -0500
Date: Mon, 24 Feb 2003 22:17:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <13760000.1046153824@[10.10.2.4]>
In-Reply-To: <20030225051956.GA18302@f00f.org>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmast
 er.ca> <1510000.1045942974@[10.10.2.4]>
 <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]>
 <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]>
 <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]>
 <20030224065826.GA5665@work.bitmover.com>
 <1046093309.1246.6.camel@irongate.swansea.linux.org.uk>
 <20030225051956.GA18302@f00f.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> _If_ it harms performance on small boxes.
> 
> You mean like the general slowdown from 2.4 - >2.5?
> 
> It seems to me for small boxes, 2.5.x is margianlly slower at most
> things than 2.4.x.

Can you name a benchmark, or at least do something reproducible between
versions, and produce a 2.4 vs 2.5 profile? Let's at least try to fix it ...

M.

