Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVARU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVARU7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVARU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:59:48 -0500
Received: from [205.233.219.253] ([205.233.219.253]:6039 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261424AbVARU7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:59:45 -0500
Date: Tue, 18 Jan 2005 15:59:32 -0500
From: Jody McIntyre <lkml@modernduck.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FireWire 800
Message-ID: <20050118205932.GK25389@conscoop.ottawa.on.ca>
References: <200501171116.05565.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501171116.05565.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 11:16:05AM +0000, Mark Watts wrote:
> 
> LaCie sell the following FireWire 800 card:
> http://www.lacie.com/uk/products/product.htm?pid=10173
> 
> According to the manual, it conforms to both the OHCI and EHCI specs.
> 
> Does this card work out of the box with the standard Linux FireWire drivers?

I haven't used that card specifically, but it should work.  You may want
to email the linux1394-user list to see if anyone has any specific
experience with it.

I caution against believing any spec sheet that claims "EHCI compliance"
from a 1394 card since that applies only to USB.

Jody

> I'd like to get one of these cards to connect my LaCie 1TB 
> USB2/FireWire400/FireWire800 drive to.
> 
> Cheers,
> 
> Mark.
> 
> 
> -- 
> Mark Watts
> Senior Systems Engineer
> QinetiQ Trusted Information Management
> Trusted Solutions and Services group
> GPG Public Key ID: 455420ED
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
