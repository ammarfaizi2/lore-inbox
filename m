Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbTHVGhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 02:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTHVGhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 02:37:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:41741 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263044AbTHVGhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:37:23 -0400
Date: Fri, 22 Aug 2003 08:34:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br
Subject: Re: [PATCH] 2/10 2.4.22-rc2 fix __FUNCTION__ warnings drivers/hotplug
Message-ID: <20030822063452.GE734@alpha.home.local>
References: <20030821012932.7179f30c.vmlinuz386@yahoo.com.ar> <20030822052000.GA7589@kroah.com> <20030822031012.0036b2ce.vmlinuz386@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822031012.0036b2ce.vmlinuz386@yahoo.com.ar>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 03:10:12AM -0300, Gerardo Exequiel Pozzi wrote:
> >Resolving www.vmlinuz.com.ar... done.
> >Connecting to www.vmlinuz.com.ar[65.200.24.183]:80... connected.
> >HTTP request sent, awaiting response... 404 Not Found
> >22:18:36 ERROR 404: Not Found.
> 
> That strange the IP is 200.32.4.71 and not 65.200.24.183 (similar in your mail headers).
> 
> dns problem ?

this address took ages to resolve here. Since 65.200.24.183 is "mail.kroah.com",
I suspect, that Greg's DNS timed out and returned something it new for an
unknown reason. So Greg was looking for your file on his server :-)

This reminds me of the old joke of creating warez.<your_domain> which points to
127.0.0.1, then you advertise for it in newsgroups and have people reply
"I already have them all" :-)

Cheers,
Willy

