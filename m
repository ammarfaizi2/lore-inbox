Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262041AbSIYSDN>; Wed, 25 Sep 2002 14:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSIYSDN>; Wed, 25 Sep 2002 14:03:13 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:6058 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S262041AbSIYSDM>; Wed, 25 Sep 2002 14:03:12 -0400
Date: Wed, 25 Sep 2002 14:08:17 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: What/Where are the latest aic7xxx ? (was:aic7xxx support foraic7902)
In-Reply-To: <1338716224.1032976056@aslan.btc.adaptec.com>
Message-ID: <Pine.LNX.4.44.0209251402060.14461-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Justin ,
	What is the latest version # of the aic7xxx driver ?
	Where is the latest version of the aic7xxx driver ?
	I've been to:
		http://people.freebsd.org/~gibbs/linux/
	and it shows 6.2.5 .  My kernel 2.4.19 says 6.2.6 .
	An email from you to the list mentions you rolling a 6.2.7 quite
	sometime ago .  Help !-} .  Tia ,  JimL

On Wed, 25 Sep 2002, Justin T. Gibbs wrote:
> > Justin,
> > I've seen a special U320 driver aic79xx v1.10, but I suppose that the new
> > U320 controllers will be folded into a new version of your aic7xxx driver
> > (?).
> Nope.  The U320 chips will never be supported in the aic7xxx driver due
> to their very different architecture.  aic79xx v1.1.0 (or 1.1.1 which
> includes the port to the 2.5.X kernels) is what you want.
> > If so, I'd like to know which version of the aic7xxx driver will
> > include support of the new aic7902 controller, and which kernel version
> > will be targeted to have that folded in.
> Which kernel version it will be folded into is beyond my control.  The
> code has been sent to both Marcelo and Linus.
> --
> Justin
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

