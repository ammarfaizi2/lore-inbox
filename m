Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310477AbSCBXOr>; Sat, 2 Mar 2002 18:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310479AbSCBXO0>; Sat, 2 Mar 2002 18:14:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310477AbSCBXOR>; Sat, 2 Mar 2002 18:14:17 -0500
Subject: Re: Network Security hole (was -> Re: arp bug )
To: ja@ssi.bg (Julian Anastasov)
Date: Sat, 2 Mar 2002 23:27:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), erich@uruk.org,
        szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.44.0203030035030.9147-100000@u.domain.uli> from "Julian Anastasov" at Mar 03, 2002 12:46:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hIuK-0000Mv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > rp_filter is an add on - not exactly default standards behaviour. If you
> > want to make the case that rp_filter = 2 means apply a both way rule then
> > I've personally no problem with that argument
> 
> 	The rp_filter value of 2 is not support from Linux and

Language confusion - "if you want to make the case" = "if you want to argue
that a value of rp_filter = 2 should in future (after you implement it) mean
apply a both way rule - then I agree)

I'm glad about your RFC1812 cite btw - the number of problems I've seen with
one of the distros defaulting to rp_filter = 1 was large.

Alan
