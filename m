Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUBWJXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUBWJXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:23:33 -0500
Received: from smtpcl1.fiducia.de ([195.200.32.50]:50108 "EHLO
	smtpcl1.fiducia.de") by vger.kernel.org with ESMTP id S261892AbUBWJXa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:23:30 -0500
Sensitivity: 
Subject: Antwort: Re: distinguish two identical network cards
To: linux-kernel@vger.kernel.org
Message-ID: <OF22476E20.9F99DF80-ONC1256E43.0033DA91@fiducia.de>
From: andreas.hartmann@fiducia.de
Date: Mon, 23 Feb 2004 10:26:17 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

> Hi,
>
> If its physically identifying the cards that you want,
> then you can  use 'ethtool' for it.  ' -p ' option of
> ethtool will help you physically identify the cards.

unfortunatelly, it doesn't help. I want to know the physical location of the
NIC, because I have to configure, e.g., the lower NIC should be eth0 and the
upper one eth1 (or vice versa).

Kind regards,
Andreas Hartmann

> > Hello!
> >
> > I've got a little problem with XSeries machines, containing two identical
> > builtin Broadcom NIC's. Is there any chance to get some information, which
> > one of the two cards is the upper, and which one is the lower card?
> > I need this information, because I want to install a lot of these machines
> > automatically.
> >
> >
> > Thank you for every hint,
> > kind regards,
> > Andreas Hartmann
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> HomePage: http://puggy.symonds.net/~krishnakumar
>
>
Mit freundlichen Grüßen,
Andreas Hartmann

Fiducia IT AG
SYTSM
Ottostraße 22a
D-76227 Karlsruhe
Telefon +49 (0) 721 4004-5144
andreas.hartmann@fiducia.de
www.fiducia.de


