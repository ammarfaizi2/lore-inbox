Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTKFLQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 06:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTKFLQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 06:16:21 -0500
Received: from f20.mail.ru ([194.67.57.52]:29714 "EHLO f20.mail.ru")
	by vger.kernel.org with ESMTP id S263497AbTKFLQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 06:16:20 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Larry McVoy=?koi8-r?Q?=22=20?= <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net down=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [212.30.182.96]
Date: Thu, 06 Nov 2003 14:22:37 +0300
In-Reply-To: <20031105151941.GA4195@work.bitmover.com>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AHiDl-0000It-00.arvidjaar-mail-ru@f20.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




-----Original Message-----

> 
> bkbits is definitely up but we did switch T1 providers recently.
> That included changing the routes in the backbone.  The only thing I can
> think of is that your part of the backbone does not have a route for us.
> We're 192.132.92.*, see if you can traceroute to us.
> 

I can't traceroute behind NAT firewall but I can ping it no problems:

root@student8:/#> ping linux.bkbits.net
linux.bkbits.net is alive

the problem is attempt to enter any repository there (linux-2.5, linux-2.4
or the third, I forgot) just times out.

Oh well, I have to try once more when I am back on my regular system.

thank you

-andrey

> On Wed, Nov 05, 2003 at 02:06:24PM +0300, "Andrey Borzenkov"  wrote:
> > 
> > For several days I cannot connect to it. I can reach as far as to
> > front page but clicking on linux-2.4 or linux-2.5 just timeouts.
> > 
> > TIA
> > 
> > -andrey
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> 
