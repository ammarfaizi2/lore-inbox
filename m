Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750915AbWFEKgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWFEKgf (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWFEKgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:36:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750915AbWFEKge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:36:34 -0400
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jeff@garzik.org>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1149503559.30554.10.camel@localhost.localdomain>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605013223.GD17361@havoc.gtf.org>
	 <20060605065856.GA1313@electric-eye.fr.zoreil.com>
	 <1149503559.30554.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 12:36:24 +0200
Message-Id: <1149503784.3111.48.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 11:32 +0100, Alan Cox wrote:
> Ar Llu, 2006-06-05 am 08:58 +0200, ysgrifennodd Francois Romieu:
> > Jeff Garzik <jeff@garzik.org> :
> > [...]
> > > In general, I'm a bit disappointed at the time it takes new drivers to
> > > reach the upstream kernel.  I grant that a lot of vendor drivers are
> > > unreadable, unmergable shite...  but on the other side of the coin, I
> > > see a lot of decent drivers get stalled simply because they aren't
> > > perfect.
> > 
> > Could you provide an informal list of a few drivers which are currently
> > stalled ?
> 
> It isn't just drivers. Xen has the same problem.

Xen has many problems. This is not nearly their biggest ;)



