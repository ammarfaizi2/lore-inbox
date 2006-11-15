Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030979AbWKOU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030979AbWKOU3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWKOU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:29:54 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:30154 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030979AbWKOU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:29:53 -0500
Date: Wed, 15 Nov 2006 15:29:45 -0500
To: Jan Pieter <pptp@jp.dhs.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: The return of the ITeX PCI ADSL card for 2.6 kernels
Message-ID: <20061115202945.GB8238@csclub.uwaterloo.ca>
References: <200611110116.29320.pptp@jp.dhs.org> <20061113091017.66e58a9b@freekitty> <200611131722.kADHMkDq007954@turing-police.cc.vt.edu> <200611151818.38436.pptp@jp.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611151818.38436.pptp@jp.dhs.org>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 06:18:38PM +0100, Jan Pieter wrote:
> You also need an ADSL library. That info is available, but it takes a *lot* of
> hard work to implement. On the other hand, all future adsl drivers can use
> the library. Dsl drivers are closed source because of this library. If such
> library existed, there would be no reason for manufacturers to do closed
> source Linux drivers.
> 
> I have 3 cards working now. Alcatel also sold it, as 'Speedtouch PC'. So it
> must be more than 45 ;-)

I know the Sangoma S518 also uses a binary blob for the ADSL component
for I guess the same reason.  At least they maintain their drivers so
their cards work with current kernels (as long as you use one of the
architectures they compile the binary blob for).

Stupid secret libraries. :(

Of course claiming such drivers are GPL is nonsense in my opinion.

--
Len Sorensen
