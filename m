Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310473AbSCBW2D>; Sat, 2 Mar 2002 17:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310474AbSCBW1x>; Sat, 2 Mar 2002 17:27:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27909 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310473AbSCBW1m>; Sat, 2 Mar 2002 17:27:42 -0500
Subject: Re: Network Security hole (was -> Re: arp bug )
To: ja@ssi.bg (Julian Anastasov)
Date: Sat, 2 Mar 2002 22:40:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), erich@uruk.org,
        szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.44.0203022217120.7823-100000@u.domain.uli> from "Julian Anastasov" at Mar 03, 2002 12:20:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hIAb-0000E6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> behavior causes some problems for setups with rp_filter protection
> and interfaces attached to same hub. If you want to find the reason
> for this, here it is:

rp_filter is an add on - not exactly default standards behaviour. If you
want to make the case that rp_filter = 2 means apply a both way rule then
I've personally no problem with that argument
