Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319011AbSIIXrR>; Mon, 9 Sep 2002 19:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319014AbSIIXrR>; Mon, 9 Sep 2002 19:47:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:45800 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319011AbSIIXrQ>;
	Mon, 9 Sep 2002 19:47:16 -0400
Date: Mon, 9 Sep 2002 16:51:59 -0700
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.34 : drivers/net/irda/irtty.c __FUNCTION__ fix
Message-ID: <20020909235159.GB28966@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.44.0209091859290.973-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209091859290.973-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 07:03:53PM -0400, Frank Davis wrote:
> Hello all,
>      The following patch fixes several __FUNCTION__ related errors. Please 
> review for inclusion. 
> 
> Regards,
> Frank

	I can only promise you to put it in my patch queue (which is
already backlogged). I've already added it on my web page (so I won't
forget it). It would have been nicer to not add a space around the
function name, but who cares.
	Please also note that currently irtty is broken, so use at
your own risks...
	Thanks...

	Jean
