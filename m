Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751114AbWFENmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWFENmM (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWFENmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:42:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27044 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751097AbWFENmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:42:11 -0400
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
From: Arjan van de Ven <arjan@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jeff@garzik.org>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
In-Reply-To: <20060605132732.GA23350@tuxdriver.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605010636.GB17361@havoc.gtf.org>
	 <20060605085451.GA26766@infradead.org>
	 <20060605132732.GA23350@tuxdriver.com>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 15:42:04 +0200
Message-Id: <1149514924.3111.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Of course, I didn't know there were serious concerns about this
> driver's origin.  I hope we aren't confusing this with the atheros
> driver...?
> 
> > Please don't let this reverse engineering idiocy hinder wireless driver
> > adoption, we're already falling far behind openbsd who are very successfull
> > reverse engineering lots of wireless chipsets.
> 
> This bugbear does seem to keep visiting us.  It is a bit of a
> minefield.
> 
> I'm inclined to think that Christoph and Arjan are right, that we
> have been too cautious.  Of course, neither of these fine gentlemen
> are known for their timidity... :-)
> 
> Does not the Signed-off-by: line on a patch submission give us some
> level of "good faith" protection?

I would suggest asking them an explicit "did you copy anything" and make
sure their "we didn't copy" answer is in the description of the original
patch submission.
> 
> I'm tempted to take contributors at their word, that they have produced
> their own work and not copied from others.  What else do we need?

to a large degree that's all you can do. (of course you can look at the
code for something that looks "obviously not from here" as well, and we
all tend to do that anyway since such stuff tends to highly violate
coding style anyway)

