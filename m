Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUBAV1L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUBAV1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:27:11 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:35802 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265598AbUBAV1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:27:08 -0500
Date: Sun, 1 Feb 2004 22:27:05 +0100
From: David Weinehall <tao@acc.umu.se>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Christian Borntraeger <kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
Message-ID: <20040201212705.GB15492@khan.acc.umu.se>
Mail-Followup-To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
	Christian Borntraeger <kernel@borntraeger.net>,
	linux-kernel@vger.kernel.org
References: <200402012202.07204.kernel@borntraeger.net> <Pine.LNX.4.44.0402012314310.6574-100000@midi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0402012314310.6574-100000@midi>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 11:16:56PM +0200, Markus Hästbacka wrote:
> On Sun, 1 Feb 2004, Christian Borntraeger wrote:
> >
> > In 2.6 there is no 497 days limit, as jiffies are now 64 bit.
> >
> Ok, I just would be intrested in a patch for 2.0 and 2.4 to get these
> jiffies to 64 bit.
> > By the way: Having a machine with more than 497 days of uptime normally
> > shows a serios lack of security awareness..
> >
> I know, but running a 2.0.x machine with that kind of uptime isn't really
> that bad, thought if the machine has alot of accounts it wouldn't be that
> great idea.
 
Well, you're soon going to reboot to install the upcoming 2.0.40, right?
And I promise to release 2.0.41 before you've had 497 days of uptime
with that one... :-)

> But anyway, thanks for the information!


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
