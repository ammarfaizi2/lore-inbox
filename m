Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUH2Few@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUH2Few (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 01:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUH2Few
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 01:34:52 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:2686 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265487AbUH2Far convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 01:30:47 -0400
Date: Sat, 28 Aug 2004 22:30:18 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: alan@lxorguk.ukuu.org.uk, milek@rudy.mif.pg.gda.pl,
       usenet-20040502@usenet.frodoid.org, miles.lane@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-Id: <20040828223018.53ec62e2.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.60L.0408290154030.15099@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
	<87hdqyogp4.fsf@killer.ninja.frodoid.org>
	<Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
	<1093174557.24319.55.camel@localhost.localdomain>
	<Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
	<1093354658.2810.31.camel@localhost.localdomain>
	<Pine.LNX.4.60L.0408290154030.15099@rudy.mif.pg.gda.pl>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 02:14:03 +0200 (CEST)
Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> wrote:

> If fact Solaris works quite well on usual desktop size computer.

Check out the Solaris driver selection on x86 these days,
it still stinks.  It is unlikely they'll ever have the coverage
Linux does any time soon.

Frankly, if the only specific technical feature Sun has to brag
about in Solaris 10 is DTrace, that's pretty sad.  Even more so,
most of the bugs I see being fixed in Solaris kernel patches
are performance regressions against Linux.  This, given how things
were 6 or 7 years ago and the things the Solaris folks used to
flame us for, I find particularly amusing.
