Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbTIMWKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbTIMWKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:10:33 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:22686 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262230AbTIMWK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:10:28 -0400
Subject: RE: People, not GPL  [was: Re: Driver Model]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Schwartz <davids@webmaster.com>
Cc: Pascal Schmidt <der.eremit@email.de>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEGEGIAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKEEGEGIAA.davids@webmaster.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063490941.9402.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 13 Sep 2003 23:09:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 22:19, David Schwartz wrote:
>  
> > If people put GPL_ONLY symbol exports in their code, that's their call
> > to make, is it not? It's their code and they're free to say "well, this
> > is my code, and if you use this symbol, I consider your stuff to be a
> > derived work". Once again it's up to the lawyers to decide whether
> > this has legal value or not.
> 
> 	If it has legal value, then it's an additional restriction.

If it has legal value in showing the work is derivative thats not an
additional restriction. Its merely showing the intent of the author. If 
someone creates a work and its found to be derivative and they didnt
make it GPL compatible they get sued, thats also not an additional
restriction its what the GPL says anyway.

That is the whole point of EXPORT_SYMBOL_GPL, it doesn't enforce
anything and Linus was absolutely specific it should not do the
enforcing. Its a hint and a support filter.

