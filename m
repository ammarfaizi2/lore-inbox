Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVIAUS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVIAUS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVIAUS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:18:26 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:50646 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030361AbVIAUSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:18:25 -0400
Subject: Re: State of Linux graphics
From: Jim Gettys <jg@freedesktop.org>
Reply-To: jg@freedesktop.org
To: Andreas Hauser <andy@splashground.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
In-Reply-To: <20050901163958.9589.qmail@paladin.fortunaty.net>
References: <43171D33.9020802@tungstengraphics.com>
	 <1125590374.9419.35.camel@localhost.localdomain>
	 <20050901163958.9589.qmail@paladin.fortunaty.net>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 16:18:27 -0400
Message-Id: <1125605907.10488.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not at all.

We're pursuing two courses of action right now, that are not mutually
exclusive.

Jon Smirl's argument is that we can satisfy both needs simultaneously
with a GL only strategy, and that doing two is counter productive,
primarily on available resource grounds.

My point is that I don't think the case has (yet) been made to put all
eggs into that one basket, and that some of the arguments presented for
that course of action don't hold together.

			- Jim

On Thu, 2005-09-01 at 16:39 +0000, Andreas Hauser wrote:
> jg wrote @ Thu, 01 Sep 2005 11:59:33 -0400:
> 
> > Legacy hardware and that being proposed/built for the developing world
> > is tougher; we have code in hand for existing chips, and the price point
> > is even well below cell phones on those devices. They don't have
> > anything beyond basic blit and, miracles of miracles, alpha blending.
> > These are built on one or two generation back fabs, again for cost.
> > And as there are no carriers subsidizing the hardware cost, the real
> > hardware cost has to be met, at very low price points.  They don't come
> > with the features Allen admires in the latest cell phone chips.
> 
> So you suggest, that we, that have capable cards, which can be had for
> < 50 Euro here, see that we find something better than X.org to run
> on them because X.org is concentrating on < 10 Euro chips?
> Somehow i always thought that older xfree86 trees were just fine for them.
> 
> Andy

