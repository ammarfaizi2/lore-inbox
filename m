Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRBWAQ0>; Thu, 22 Feb 2001 19:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130258AbRBWAQQ>; Thu, 22 Feb 2001 19:16:16 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:14836 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129290AbRBWAQG>;
	Thu, 22 Feb 2001 19:16:06 -0500
Date: Fri, 23 Feb 2001 01:15:51 +0100
From: David Weinehall <tao@acc.umu.se>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Gabi Davar <gabi@SHUNRA.co.il>,
        "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.0.x Questions
Message-ID: <20010223011551.E8638@khan.acc.umu.se>
In-Reply-To: <F1629832DE36D411858F00C04F24847A035913@SALVADOR> <3A95A230.9CC5325C@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A95A230.9CC5325C@matchmail.com>; from mfedyk@matchmail.com on Thu, Feb 22, 2001 at 03:35:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 03:35:12PM -0800, Mike Fedyk wrote:
> Gabi Davar wrote:
> > 
> > Hello I have two questions regarding Linux 2.0.x
> > 
> > 1. Did anybody tried running Linux 2.0.x on the Intel i840 chipset based
> > boards?
> > 
> > 2. Does anybody knows of a 2.0.x driver for Intel's 82543GC Gigabit
> > Ethernet MAC (aka e1000) ?
> > 
> > Thanks in advance,
> > 
> > Best regards,
> > Gabi Davar
> What are your reasons with staying on the 2.0 kernel series?
> 
> You probably won't find very many 2.0 users here anymore.  Did you contact
> the 2.0 maintainer?

No, he didn't, but I do read LKML. I've been searching around a little
(not much yet; I've been busy) for evidence of people using the
i840 with v2.0.xx, but have so far found none. I can't see any reason
why it shouldn't work, however.

The Gigabit 82543GC, on the other hand, is probably something that you'll
have to get a newer kernel to be able to use (unless Intel has released
a driver for it that they haven't submitted to me; the only Gigabit
driver in v2.0.39 is, if I remember correctly, yellowfin.)


/David Weinehall, maintainer of v2.0.xx
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
