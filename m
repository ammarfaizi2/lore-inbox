Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283043AbRK1Nnu>; Wed, 28 Nov 2001 08:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283038AbRK1Nnk>; Wed, 28 Nov 2001 08:43:40 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:41857 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S283043AbRK1Nn0>; Wed, 28 Nov 2001 08:43:26 -0500
Date: Wed, 28 Nov 2001 08:59:23 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <034001c177f2$61051ac0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.40.0111280855270.88-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, Martin Eriksson wrote:

> I'm starting to believe it has something to do with the parallel port being
> unconnected, thus sending random signals to the mobo causing an interrupt?
> If this is the case it is very possible that it has to do with correct
> grounding also...

Actually I believe way back there was a discussion about this same
message, Alan Cox said he thought it was caused by bad parallel ports.

That said I see it on 2 Athlon boxes with VIA chipsets.  One I had never
seen the message until I removed the parallel port QuickCam I had hooked
up.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

