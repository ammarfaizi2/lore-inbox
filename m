Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTEZQbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEZQbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 12:31:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42759 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261787AbTEZQbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 12:31:11 -0400
Date: Mon, 26 May 2003 18:44:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>, willy@w.ods.org,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: Undo aic7xxx changes
Message-ID: <20030526164404.GA11381@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <20030524111608.GA4599@alpha.home.local> <20030525125811.68430bda.skraw@ithnet.com> <200305251447.34027.m.c.p@wolk-project.de> <20030526170058.105f0b9f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526170058.105f0b9f.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 05:00:58PM +0200, Stephan von Krawczynski wrote:
> On Sun, 25 May 2003 14:47:56 +0200
> Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
> 
> > On Sunday 25 May 2003 12:58, Stephan von Krawczynski wrote:
> > 
> > Hi Stephan,
> > before trying this, could you please update to aic20030523? Thank you.
> > 
> > 
> > ciao, Marc
> 
> Hello Marc,
> 
> I did this. The combination rc3+aic20030523 survived the first day of tests. So
> it seems at least better than rc3+aic20030520.

The same has been running on my Alpha since yesterday evening on a 54GB raid0
which I transformed to raid5 (39 GB backed up to IDE ; mkraid ; 39GB restored).

Still alive.
Cheers,
Willy

