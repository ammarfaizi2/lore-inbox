Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUIRBxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUIRBxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 21:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUIRBxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 21:53:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5034 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269102AbUIRBxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 21:53:32 -0400
Date: Fri, 17 Sep 2004 21:29:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: tuxrocks@cox.net
Cc: linux-kernel@vger.kernel.org, dhollis@davehollis.com
Subject: Re: open source realtek driver for 8180
Message-ID: <20040918002931.GA5327@logos.cnet>
References: <20040915161113.BVQI25194.lakermmtao01.cox.net@smtp.east.cox.net> <1095268473.6499.4.camel@dhollis-lnx.kpmg.com> <200409151954.18035.tuxrocks@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409151954.18035.tuxrocks@cox.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In my experience the realtek binary driver is crap - it brings up the card 
and transfers data correctly - but stops communication after some period of time, 
sometimes 10 minutes, sometimes 1 hour.

It oopses on card removal, doenst handle anything other than normal 
operation for more than 1 hour.

On RH's 2.4.20-8, all of that.

On Wed, Sep 15, 2004 at 07:54:18PM -0500, tuxrocks@cox.net wrote:
> The realtek drivers have worked for me, but only (as you said) for 2.4.  They 
> also don't support monitor mode, which I would like to use.
> I had similar experiences with the sourceforge projects mentioned.  The 
> rtl8180+sa2400 bailed with numerous warnings.  The project you mention might 
> be the other one on sourceforge, rtl-ddp.  Things seemed to be moving, but 
> then stalled.  It compiles and insmods but doesn't have the wireless 
> extensions supported yet.  I'm sure everyone involved in the projects is 
> busy, but I'm just trying to see if going out and buying a 20 or 30 dollar 
> card that is supported would be my best bet.
