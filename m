Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUHZLOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUHZLOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUHZLLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:11:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:34453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268729AbUHZLIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:08:51 -0400
Date: Thu, 26 Aug 2004 04:04:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: tim@physik3.uni-rostock.de, johnstul@us.ibm.com,
       albert@users.sourceforge.net, george@mvista.com,
       hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       voland@dmz.com.pl, nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
Message-Id: <20040826040436.360f05f7.akpm@osdl.org>
In-Reply-To: <20040819191537.GA24060@elektroni.ee.tut.fi>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>
	<20040816124136.27646d14.akpm@osdl.org>
	<Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	<412285A5.9080003@mvista.com>
	<1092782243.2429.254.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	<1092787863.2429.311.camel@cog.beaverton.ibm.com>
	<1092781172.2301.1654.camel@cube>
	<1092791363.2429.319.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
	<20040819191537.GA24060@elektroni.ee.tut.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
>
> On Wed, Aug 18, 2004 at 09:42:17AM +0200, Tim Schmielau wrote:
> > Updated patch below. It's not very well tested, but it compiles, boots, 
> > and fixes the problem on i386 with the default HZ=1000 and USER_HZ=100.
> 
> Yes, it works nicely now.

So...  is this settled now?

If so, could you (Tim) please send out a fresh, changelogged version of the
patch for review?

Thanks.
