Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTA1MH5>; Tue, 28 Jan 2003 07:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTA1MH5>; Tue, 28 Jan 2003 07:07:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:15876 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265201AbTA1MH4>;
	Tue, 28 Jan 2003 07:07:56 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281217.h0SCHi43000316@darkstar.example.net>
Subject: Re: Bootscreen
To: rob@r-morris.co.uk (Robert Morris)
Date: Tue, 28 Jan 2003 12:17:44 +0000 (GMT)
Cc: Raphael_Schmid@CUBUS.COM, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301281149070.20509-100000@schubert.rdns.com> from "Robert Morris" at Jan 28, 2003 12:08:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's perfectly possible that somebody might want to make a television
> > set top box out of a standard x86 motherboard and VGA card, and not
> > have anything displayed until X starts, because the television would
> > not accept the standard VGA scanrate, but X can easily re-program that
> > to around 15 Khz.
> 
> OK, but in this case you would have problems with BIOS output etc.

Yeah, I was thinking along the lines of having a simple colour bar
generator for when the VGA output wasn't in the valid frequency range,
but your idea is better as long as the custom BIOS was easily
do-able.

> And I question the approach of automatically deciding to hide startup
> output from the user, in any case. I can imagine a set-top box user on the
> phone to the support department saying "it gets to the Starting - Please
> Wait screen, then just hangs", which would then require an engineer visit,
> as opposed to, for example, "it says Obtaining IP Address... then hangs"  
> which would give the support techie the opportunity to tell the user to
> check the ethernet cable is plugged in correctly, etc, before resorting to
> sending out an engineer.

I agree, but how many set top boxes are designed like that?  I would
prefer verbose output, but it's generally hidden from end users :-(.

John
