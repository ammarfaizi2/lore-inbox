Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbRAPXAL>; Tue, 16 Jan 2001 18:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135179AbRAPW7w>; Tue, 16 Jan 2001 17:59:52 -0500
Received: from fungus.teststation.com ([212.32.186.211]:17290 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S132131AbRAPW7j>; Tue, 16 Jan 2001 17:59:39 -0500
Date: Tue, 16 Jan 2001 23:59:33 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "richard.morgan9" <richard.morgan9@ntlworld.com>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000
In-Reply-To: <001101c0800d$50efd900$548cfd3e@abc>
Message-ID: <Pine.LNX.4.30.0101162351480.13791-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, richard.morgan9 wrote:

> I have the same problem as Urban with a recent DLink 530tx
> (rhine2).  Pulling the power cable from my atx psu (while the
> computer was "off") fixed the card, until my next reboot from
> win98.

I'm not the one with a problem but maybe it has something to do with win98
and/or the driver used there. I intend to test this myself eventually and
see if I can do something based on Donald Beckers suggestions on eeprom.

Unless someone else feels like playing with this ... anyone?

Does everyone seeing this have a Rhine-II, pci id 1106:3065, and not the
older chip found in dfe530tx with pci id 1106:3043?

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
