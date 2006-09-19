Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752028AbWISEAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbWISEAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 00:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWISEAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 00:00:06 -0400
Received: from ppp1-149.lns1.syd7.internode.on.net ([59.167.1.149]:30220 "EHLO
	lucretia.isay.com.au") by vger.kernel.org with ESMTP
	id S1752028AbWISEAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 00:00:02 -0400
Date: Tue, 19 Sep 2006 14:00:00 +1000
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Smith <tarka@internode.on.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Repeatable hang on boot with PCMCIA card present
Message-ID: <20060919040000.GB27338@lucretia.remote.isay.com.au>
References: <20060916050331.GA6685@lucretia.remote.isay.com.au> <20060918190902.d5b6a698.akpm@osdl.org> <200609182337.52990.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609182337.52990.dtor@insightbb.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: tarka@internode.on.net (Steve Smith)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 11:37:52PM -0400, Dmitry Torokhov wrote:
> Hmm, not sure why you CCed me unless you remembered I have Inspiron 8100.
> What chipset does that Linksys card use?

It's a WPC11, one of the prism family ones.  It's using the HostAP
driver.

> I just tried one of my PCMCIA cards with orinoco_cs and it booted
> fine on today's pull from Linus...

OK, I'll try it with the orinoco driver when I get a chance.

Cheers,
Steve

