Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUBAVgS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBAVgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:36:18 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:36073 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265642AbUBAVer convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:34:47 -0500
Date: Sun, 1 Feb 2004 23:34:39 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi
To: David Weinehall <tao@acc.umu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
In-Reply-To: <20040201212705.GB15492@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.44.0402012331120.6802-100000@midi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, David Weinehall wrote:
> On Sun, Feb 01, 2004 at 11:16:56PM +0200, Markus Hästbacka wrote:
> > On Sun, 1 Feb 2004, Christian Borntraeger wrote:
> > >
> > > In 2.6 there is no 497 days limit, as jiffies are now 64 bit.
> > >
> > Ok, I just would be intrested in a patch for 2.0 and 2.4 to get these
> > jiffies to 64 bit.
> > > By the way: Having a machine with more than 497 days of uptime normally
> > > shows a serios lack of security awareness..
> > >
> > I know, but running a 2.0.x machine with that kind of uptime isn't really
> > that bad, thought if the machine has alot of accounts it wouldn't be that
> > great idea.
>
> Well, you're soon going to reboot to install the upcoming 2.0.40, right?
> And I promise to release 2.0.41 before you've had 497 days of uptime
> with that one... :-)
>
Of course :)
But when you'll stop releasing stuff, then it's time to see that :)
> > But anyway, thanks for the information!
>
>
> Regards: David Weinehall
> --
>  /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
> //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> \)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
>
Btw, when is it coming? :-)

	Markus

