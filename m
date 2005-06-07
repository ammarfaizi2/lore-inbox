Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVFGSuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVFGSuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVFGSuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:50:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:47085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261953AbVFGSu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:50:29 -0400
Date: Tue, 7 Jun 2005 11:50:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Nick Craig-Wood <nick@craig-wood.com>
Cc: linux-kernel@vger.kernel.org, Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Stable 2.6.x.y kernel series...
Message-ID: <20050607185011.GB9153@shell0.pdx.osdl.net>
References: <4cHDt-8gT-7@gated-at.bofh.it> <4cHDt-8gT-9@gated-at.bofh.it> <4cHDt-8gT-5@gated-at.bofh.it> <4cOly-5Va-35@gated-at.bofh.it> <20050607165906.7CB653FF9A@irishsea.home.craig-wood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607165906.7CB653FF9A@irishsea.home.craig-wood.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Craig-Wood (nick@craig-wood.com) wrote:
> In linux.kernel, Frank Sorenson wrote:
> >  Nick Craig-Wood wrote:
> > > The next hurdle for 2.6.11-stable is to make sure that everything that
> > > went into it goes into 2.6.12.  Is there a procedure for that?
> > 
> >  Other way around.  In order to be accepted into -stable, it needs to
> >  already have been accepted into mainline.  More information at
> >  http://kerneltrap.org/node/4827/54751
> 
> It doesn't actually say that on the above web page.  I remember it
> being discussed, but it isn't on that page (unless I've missed it of
> course ;-)
> 
> It wouldn't always be appropriate either - a -stable patch might
> disable something which has a huge security hole in, wheras that sort
> of patch wouldn't get accepted in mainline.

There's lot of grey areas, those are guidelines for acceptance.  And,
per your earlier comment, we do push patches to Linus where appropriate.
Typically, we prefer to see them upstream, helps add much credibility
to the stability of the patch.
