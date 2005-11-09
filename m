Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVKIGFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVKIGFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 01:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKIGFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 01:05:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932485AbVKIGFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 01:05:07 -0500
Date: Tue, 8 Nov 2005 22:04:54 -0800
From: Chris Wright <chrisw@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, herbert@gondor.apana.org.au, torvalds@osdl.org,
       gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.14.1
Message-ID: <20051109060454.GB5856@shell0.pdx.osdl.net>
References: <20051109010729.GA22439@kroah.com> <20051108211354.546e0163.akpm@osdl.org> <20051108.212750.41206070.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108.212750.41206070.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@davemloft.net) wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Tue, 8 Nov 2005 21:13:54 -0800
> 
> > Greg KH <gregkh@suse.de> wrote:
> > >
> > > We (the -stable team) are announcing the release of the 2.6.14.1 kernel.
> > 
> > We need the fix for the net-drops-zero-length-udp-messages bug which broke
> > bind and traceroute.
> 
> Yes, and I was pretty sure I saw Herbert submit this to
> stable@kernel.org even.
> 
> In any event, yes please put that in.

Yes, it's queued, will be part of .2 review cycle.

thanks,
-chris
