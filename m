Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310447AbSCBUjP>; Sat, 2 Mar 2002 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310448AbSCBUjF>; Sat, 2 Mar 2002 15:39:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310447AbSCBUi7>; Sat, 2 Mar 2002 15:38:59 -0500
Subject: Re: Network Security hole (was -> Re: arp bug )
To: erich@uruk.org
Date: Sat, 2 Mar 2002 20:52:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ja@ssi.bg (Julian Anastasov),
        szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E16hGAW-0000Rw-00@trillium-hollow.org> from "erich@uruk.org" at Mar 02, 2002 12:31:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hGUB-0008Ou-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My general contention is that the system should, by default, behave as
> non-experts would expect, but this might be a point where we can't
> agree.

It does 8) You plug it into the network, you select the defaults in the
installation menu, you run mozilla and up comes a web site. Anything beyond
that is not non-expert.

If you want to go into the innards of the routing/arp stuff you might want
to move this to netdev@oss.sgi.com - thats the network folks list and many
of them don't read linux-kernel.

Alan
