Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264287AbRFHRwT>; Fri, 8 Jun 2001 13:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264299AbRFHRwJ>; Fri, 8 Jun 2001 13:52:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30213 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264287AbRFHRv4>; Fri, 8 Jun 2001 13:51:56 -0400
Date: Fri, 8 Jun 2001 21:23:26 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010608212326.A9664@jurassic.park.msu.ru>
In-Reply-To: <20010608181612.A561@jurassic.park.msu.ru> <Pine.GSO.3.96.1010608172843.18837A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010608172843.18837A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jun 08, 2001 at 06:08:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 06:08:46PM +0200, Maciej W. Rozycki wrote:
>  Oh well, so they cheat -- they claim in their docs the kernel may choose
> whatever address it considers appropriate and then rely on particular
> behaviour.  What for, I wonder...  I guess they weren't able to resolve
> signedness issues...

*Sigh*. Do not trust docs... even DEC docs :-(
 
>  Still it has two loops...  I'm not sure how to eliminate one of them at
> the moment, though.

Me either; I'll think about that.

>  I think we might also consider moving the
> compatibility crap into arch/alpha/kernel. 

This also would be acceptable, IMO.

Ivan.
