Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUAZMa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 07:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUAZMa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 07:30:26 -0500
Received: from mail.shareable.org ([81.29.64.88]:47233 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261575AbUAZMaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 07:30:25 -0500
Date: Mon, 26 Jan 2004 12:30:23 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Tomas Ogren <stric@ing.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Fried the onboard Broadcom 4401 network...
Message-ID: <20040126123023.GA27087@mail.shareable.org>
References: <20040125024238.GA10424@ing.umu.se> <20040126090859.GB505@elf.ucw.cz> <20040126094815.GA2060@ing.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126094815.GA2060@ing.umu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Ogren wrote:
> On 26 January, 2004 - Pavel Machek sent me these 0,4K bytes:
> > > After that, I have not been able to get link (neither see it through
> > > Linux/WinXP or the physical LED). I have tried multiple cables and my
> > > laptop is perfectly happy with all of them, but the broadcom thingie
> > > seems not. The switch doesn't see link either.
> > 
> > Try to physically unplug machine from AC for a while.
> 
> Ah, thank you! Just turning the power switch off didn't help.. I suppose
> it's kept alive (for some values of alive ;) for WOL and such..

I was startled when I bought a power meter to find that my computers
and even some monitors consume power when switched off.  I don't mean
"soft" off - even with the mechanical switch in the off position they
still consume significant power.

My AMD box consumes about 15W of power when the mechanical switch on
its power supply is off.  About 35W when the mechanical switch is on
but the computer is in the "soft off" state (i.e. what you get when
you ask it to turn itself off).

-- Jamie
