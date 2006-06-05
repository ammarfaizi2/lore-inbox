Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750866AbWFEKNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWFEKNW (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWFEKNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:13:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60387 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750866AbWFEKNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:13:20 -0400
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Andrew Morton <akpm@osdl.org>,
        Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linville@tuxdriver.com,
        Denis Vlasenko <vda@ilport.com.ua>, acx100-devel@lists.sourceforge.net,
        acx100-users@lists.sourceforge.net
In-Reply-To: <1149497109.3111.28.camel@laptopd505.fenrus.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605010636.GB17361@havoc.gtf.org>
	 <20060604181515.8faa8fcf.akpm@osdl.org>
	 <20060605083321.GA15690@rhlx01.fht-esslingen.de>
	 <1149497109.3111.28.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 11:26:55 +0100
Message-Id: <1149503215.30554.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-05 am 10:45 +0200, ysgrifennodd Arjan van de Ven:
>  It's just that a cleanroom approach is a sure way to prove
> you didn't copy. That's all.

Which is an extremely important detail especially if you have been
reverse engineering another driver for the same or similar OS where it
is likely that people will retain knowledge and copy rather than
re-implement things.

We've had "fun" with this before and the pwc camera driver. I don't want
to see a repeat of that.

Alan

