Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSAMBVJ>; Sat, 12 Jan 2002 20:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287907AbSAMBVC>; Sat, 12 Jan 2002 20:21:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17412 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287932AbSAMBUq>; Sat, 12 Jan 2002 20:20:46 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: akpm@zip.com.au (Andrew Morton)
Date: Sun, 13 Jan 2002 01:32:03 +0000 (GMT)
Cc: ed.sweetman@wmich.edu (Ed Sweetman), andrea@suse.de (Andrea Arcangeli),
        yodaiken@fsmlabs.com, jogi@planetzork.ping.de,
        rml@tech9.net (Robert Love), alan@lxorguk.ukuu.org.uk (Alan Cox),
        nigel@nrg.org, landley@trommello.org (Rob Landley),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C409B2D.DB95D659@zip.com.au> from "Andrew Morton" at Jan 12, 2002 12:23:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZVD-0003h9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And guess what?   Nobody has tested the damn thing, so it's going
> nowhere.

I've been testing it. It works for me, its not as good as the full one,
it seems obviously correct. What else am I supposed to say.

I'm pretty much exclusively running Andre's new IDE code too. In fact I'm
back to a page long list of applied diffs versus 2.4.18pre3, most of which
I need to feed Marcelo
