Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUIOVK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUIOVK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUIOVKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:10:23 -0400
Received: from [69.28.190.101] ([69.28.190.101]:50338 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267505AbUIOVJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:09:31 -0400
Date: Wed, 15 Sep 2004 17:08:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-ID: <20040915210818.GA22649@havoc.gtf.org>
References: <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <1095275660.20569.0.camel@localhost.localdomain> <4148A90F.80003@pobox.com> <20040915140123.14185ede.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915140123.14185ede.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:01:23PM -0700, David S. Miller wrote:
> On Wed, 15 Sep 2004 16:41:51 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > The point was more to show people who are doing TOE _anyway_ to a decent 
> > design.
> 
> We shouldn't be forced to refine people's non-sensible ideas which
> we'll not support anyways.

I just described a design that -we already support-.

It's generic scalable model that has application outside the acronym
"TOE".  Did you read my message, or just see 'TOE' and nothing else?

Sun used this model with their x86 cards.  Total MP did something
similar with their 4-processor PowerPC cards.

There's nothing inherently wrong with sticking a computer running
Linux inside another computer ;-)

	Jeff



