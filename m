Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTJWWnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJWWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 18:43:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27862 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261840AbTJWWnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 18:43:47 -0400
Date: Fri, 24 Oct 2003 00:43:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
       Dave Hollis <dhollis@davehollis.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.23-pre8: usbnet.c doesn't compile with gcc 2.95
Message-ID: <20031023224338.GG21490@fs.tum.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> <20031023194748.GH11807@fs.tum.de> <20031023220303.GA21242@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023220303.GA21242@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 03:03:03PM -0700, Greg KH wrote:
> On Thu, Oct 23, 2003 at 09:47:49PM +0200, Adrian Bunk wrote:
> > I'm getting the following compile error in 2.4.23-pre8 with gcc 2.95:
> 
> This can be fixed with this patch.  I'll send it to Marcelo in the next
> batch of USB fixes.

Thanks, I can confirm that this patch fixes it.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

