Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVGMS2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVGMS2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVGMS0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:26:16 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:58431 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262226AbVGMSYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:24:00 -0400
Date: Wed, 13 Jul 2005 20:11:47 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Egry G?bor <gaboregry@t-online.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
Message-ID: <20050713201147.GA23746@mars.ravnborg.org>
References: <1121273456.2975.3.camel@spirit> <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org> <1121277818.2975.68.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121277818.2975.68.camel@spirit>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 08:03:38PM +0200, Egry G?bor wrote:
> On Wed, 13 Jul 2005, Linus Torvalds wrote:
> > On Wed, 13 Jul 2005, Egry G??bor wrote:
> > > 
> > > The following patches complete the "Kconfig I18N support" patch by
> > > Arnaldo. 
> > 
> > No, I really don't want this.
> > 
> > I was told that the whole point of Arnaldo's work was that the actual po 
> > files etc wouldn't need to be with the kernel, and could be a separate 
> > package, maintained separately. Now I'm seeing patches that seem to make 
> > that a lie.
> 
> Hmm, what .po files do you say about?
Patch 19/19 contains a .po file.

	Sam
