Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQLSGbE>; Tue, 19 Dec 2000 01:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbQLSGay>; Tue, 19 Dec 2000 01:30:54 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:63236 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129480AbQLSGar>; Tue, 19 Dec 2000 01:30:47 -0500
Date: Mon, 18 Dec 2000 21:59:23 -0800 (PST)
From: ferret@phonewave.net
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <100F3C80070F@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.96.1001218215419.7004A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pardon me for not fully groking the issues here and possibly coming to a
wrong conclusion, but this has to do with SMP systems crashing at APIC
init time, just before penguin display (with fbcon at least)? If so, I
have a board that does this with certain cache settings made in the BIOS.
It's a 430HX chipset with two Pentium MMX 200s installed, *ancient* BIOS.

-- Ferret


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
