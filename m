Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSFXU7H>; Mon, 24 Jun 2002 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSFXU7G>; Mon, 24 Jun 2002 16:59:06 -0400
Received: from ns.suse.de ([213.95.15.193]:40210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315275AbSFXU7F>;
	Mon, 24 Jun 2002 16:59:05 -0400
Date: Mon, 24 Jun 2002 22:59:06 +0200
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Francois Romieu <romieu@cogenit.fr>, Frank Davis <fdavis@si.rr.com>,
       linux-kernel@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>
Subject: Re: [PATCH] 2.5.24 : drivers/net/tlan.c; drivers/net/rrunner.c
Message-ID: <20020624225906.A1708@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Francois Romieu <romieu@cogenit.fr>, Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2002 at 03:34:22PM -0400, Jeff Garzik wrote:
 > Just make sure you split it up... one of the reasons why I have stalled 
 > applying davej's 2.4.x->2.5.x rrunner patch is that it's pretty darn 
 > huge, even though the changes are fairly minor.  (nothing against davej, 
 > of course)

There are a few net drivers just like that, which have seen quite a bit
of development in 2.4.  Over time, it's possible the authors of the
drivers will submit stuff through you (or to Linus) bit by bit.
At which point, what's in my tree only serves as a "oh, you missed
this bit" service.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
