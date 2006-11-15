Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030724AbWKORSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030724AbWKORSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030725AbWKORSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:18:42 -0500
Received: from jp.dhs.org ([213.84.189.153]:43026 "EHLO debian.jp.dhs.org")
	by vger.kernel.org with ESMTP id S1030724AbWKORSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:18:42 -0500
From: Jan Pieter <pptp@jp.dhs.org>
Organization: SIP_SPOOF, Inc.
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: The return of the ITeX PCI ADSL card for 2.6 kernels
Date: Wed, 15 Nov 2006 18:18:38 +0100
User-Agent: KMail/1.9.5
References: <200611110116.29320.pptp@jp.dhs.org> <20061113091017.66e58a9b@freekitty> <200611131722.kADHMkDq007954@turing-police.cc.vt.edu>
In-Reply-To: <200611131722.kADHMkDq007954@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151818.38436.pptp@jp.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 18:22, you wrote:
> On Mon, 13 Nov 2006 09:10:17 PST, Stephen Hemminger said:
> > On Sat, 11 Nov 2006 01:16:29 +0100 Jan Pieter <pptp@jp.dhs.org> wrote:
> > > ITeX stopped support for their PCI ADSL Apollo3 chipset because
> > > they gone bankrupt. The latest Linux drivers for their chipset are
> > > for kernel 2.4.15. They are binary-only.
> >
> > Wrong list. We don't do binary drivers....
>
> On the other hand, if we can track down whoever got the wreckage of the
> bankrupt company, they might be persuaded to cough up enough documentation
> to allow writing an open driver....

You also need an ADSL library. That info is available, but it takes a *lot* of
hard work to implement. On the other hand, all future adsl drivers can use
the library. Dsl drivers are closed source because of this library. If such
library existed, there would be no reason for manufacturers to do closed
source Linux drivers.

> Anybody know how many Apollo3-based cards were sold?  Enough to make it
> worth pursuing, or did ITeX go under because only 45 people bought the
> card, and 43 of them have since disposed of the hardware?

I have 3 cards working now. Alcatel also sold it, as 'Speedtouch PC'. So it
must be more than 45 ;-)


Jan Pieter.
