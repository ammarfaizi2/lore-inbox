Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277743AbRJRPVo>; Thu, 18 Oct 2001 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277750AbRJRPVf>; Thu, 18 Oct 2001 11:21:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50049 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277743AbRJRPVY>; Thu, 18 Oct 2001 11:21:24 -0400
Date: Thu, 18 Oct 2001 11:21:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Non-GPL modules
In-Reply-To: <200110181453.f9IErMI18783@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.3.95.1011018110604.802A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Peter T. Breuer wrote:

> "Richard B. Johnson wrote:"
> > We have a data interface that feeds high-speed data from 4,000 +
> > X-Ray detectors directly to memory at RAM/Bus memory speeds. There
> > is no way in hell that we are going to let the world know how this
> 
> Oh my gosh. You aren't working on a project for CERN too, are you?
> 
> Peter

No. Amongst many other things, we make the "Exact" baggage scanners
market by L3 division of Lockheed-Martin. All airplane baggage
will eventually be scanned (at baggage-conveyor speeds) at all
airports serving commercial airliners. The scanning detects
various devices and chemical compounds. It uses X-Rays of different
frequencies (hardness) to actually detect chemical compounds
at their elementary atomic levels.

For instance, most X-Ray systems only detect density. The X-Ray
density of a jar of peanut butter is similar to the density of
the explosive C4. Without chemical discrimination, anybody with
a jar of peanut butter in their luggage is suspect. However,
by using dual-energy, we can zero in on nitrogen, while allowing
the same-density substances containing other atoms.

We do this in an incredibly fast hardware/software environment
so that baggage runs through the machines at normal conveyor
speeds, not slowing down the loading/boarding process.

This is NOT the scanner used to X-Ray carry-on luggage. That
uses a much less robust and cheaper process because there
are attendants present that can ask that suspect carry-on
luggage be opened for inspection. 

Presently, we are using DEC/Alpha machines for the hardware/software
interface. Our next generation will use PC/AT/Linux machines for
the same function (at twice the performance).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


