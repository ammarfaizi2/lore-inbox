Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUBAWTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUBAWTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:19:06 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:63200 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265526AbUBAWTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:19:02 -0500
Date: Sun, 1 Feb 2004 23:19:00 +0100
From: David Weinehall <tao@acc.umu.se>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
Message-ID: <20040201221900.GE15492@khan.acc.umu.se>
Mail-Followup-To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
	linux-kernel@vger.kernel.org
References: <20040201214410.GC15492@khan.acc.umu.se> <Pine.LNX.4.44.0402020006120.7215-100000@midi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0402020006120.7215-100000@midi>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 12:07:40AM +0200, Markus Hästbacka wrote:
> On Sun, 1 Feb 2004, David Weinehall wrote:
> > On Sun, Feb 01, 2004 at 11:34:39PM +0200, Markus Hästbacka wrote:
> > > On Sun, 1 Feb 2004, David Weinehall wrote:
> > [snip]
> > > > Well, you're soon going to reboot to install the upcoming 2.0.40, right?
> > > > And I promise to release 2.0.41 before you've had 497 days of uptime
> > > > with that one... :-)
> > > >
> > > Of course :)
> > > But when you'll stop releasing stuff, then it's time to see that :)
> >
> > When I stop releasing stuff, it's time to upgrade to the 3.x kernel...
> >
> Never! This boxen is sticking with 2.0 :-)
> > [snip]
> >
> > > Btw, when is it coming? :-)
> >
> > When I've got enough feedback that 2.0.40-rc8 is working...  Soon, very
> > soon.  Unless, of course, you were talking about 2.0.41, which is quite
> > some time away... :-)
> >
> I see no problems with it, maybe I should do some tests or something? :)

Well, since most of the changes in the latest kernels involve
networking, trying it with various different network-adapters would be
interesting, and stress-testing the network-code in general.

If you have the hardware or a really good confidence, a recent
2.2-kernel to compare with and sufficient knowledge of C, have a look at
the network-drivers for a2065 and ariadne, both of which lack the
padding-fixes the other adapters have, since I didn't want to touch that
mess...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
