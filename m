Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTHFRBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270734AbTHFRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:01:50 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:17507 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S270652AbTHFRBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:01:47 -0400
Date: Wed, 6 Aug 2003 12:01:45 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030806120145.A15543@hexapodia.org>
References: <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <m1fzkiwnru.fsf@frodo.biederman.org> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org> <20030806021304.E5798@almesberger.net> <m1llu7ushr.fsf@frodo.biederman.org> <20030806103758.H5798@almesberger.net> <20030806105830.B26920@hexapodia.org> <3F312C65.9000201@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F312C65.9000201@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Wed, Aug 06, 2003 at 12:27:17PM -0400
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:27:17PM -0400, Chris Friesen wrote:
> Andy Isaacson wrote:
> > On Wed, Aug 06, 2003 at 10:37:58AM -0300, Werner Almesberger wrote:
> >>Eric W. Biederman wrote:
> >>>to keep your latency down.  Do any ethernet switches do cut-through?
> >>According to Google, many at least claim to do this.
> > 
> > Do you have any references for this claim?  I have never seen one that
> > panned out (at least not since the high-end-10mbps days).
> > 
> > Just to be clear, I am asking for an example of a Gigabit Ethernet
> > switch that supports cut-through switching.  I contend that there is no
> > such beast commercially available today.
> 
> A few seconds of googling shows that these claim it:
> http://www.blackbox.com.mx/products/pdf/europdf/81055.pdf

This is a 100mbit product, not gigabit.

> http://www.directdial.com/dd2/images/pdf_specsheet/J4119AABA.pdf

The products referred to here are the HP ProCurve Switch 8000M and the
HP ProCurve Switch 1600M.  The 1600M has only one (optional) GigE port,
so it's disqualified.  The 8000M has up to 10 GigE ports, so it could be
interesting.  The PDF says "Cut-through Layer 3 switching", which is a
bit of marketese that I have trouble deciphering.  I'll run some tests
on our 4000M and see if I can come to any conclusions...  if anyone can
point to a whitepaper on the ProCurve chassis design I'd apprecate it.

> I'm sure there are others...

I'm still curious.

-andy
