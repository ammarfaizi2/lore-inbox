Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbTGEIux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbTGEIux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 04:50:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16652
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265998AbTGEIuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 04:50:51 -0400
Date: Sat, 5 Jul 2003 02:00:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jari Ruusu <jari.ruusu@pp.inet.fi>, hch@infradead.org,
       cfriesen@nortelnetworks.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
In-Reply-To: <20030705015802.04d89255.akpm@osdl.org>
Message-ID: <Pine.LNX.4.10.10307050157530.21771-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Hold up!  Recall some changes can not be micro sliced.  If this the case
also, you need to evaluate assigning to a selected committee to be formed
to review and parse.

If you do not understand the scope of the change set, then find somebody
(pural if needed) to parse and report.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 5 Jul 2003, Andrew Morton wrote:

> Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
> >
> > I have posted patches to be included in mainline.
> 
> Have you?  I only recall a single humongous patch from you which was far
> too large and did too many things at once to be reviewed and generally
> understood by other kernel developers.
> 
> If you have a sequence of one-concept-per-patch documented changes then
> please tell us where to find it.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

