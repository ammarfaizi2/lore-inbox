Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVGMQ2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVGMQ2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVGMQ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:28:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262691AbVGMQ0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:26:49 -0400
Date: Wed, 13 Jul 2005 09:26:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Chris Wright <chrisw@osdl.org>, stable@kernel.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [stable] [patch 1/1] uml: fix TT mode by reverting "use fork instead of clone"
Message-ID: <20050713162632.GL19052@shell0.pdx.osdl.net>
References: <20050712172838.271E8D9A84@zion.home.lan> <20050712185023.GY19052@shell0.pdx.osdl.net> <200507131533.00817.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507131533.00817.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Blaisorblade (blaisorblade@yahoo.it) wrote:
> On Tuesday 12 July 2005 20:50, Chris Wright wrote:
> > * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > > For now there's not yet a fix for this patch, so for now the best thing
> > > is to drop it (which was widely reported to give a working kernel).
> > 
> > And upstream will leave this in, working to real fix?
> 
> Preferably yes, but this depends on whether the fix is found. Otherwise this 
> exact patch will be merged upstream too.

OK, thanks, queued to -stable.
-chris
