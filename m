Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264108AbRFNWEM>; Thu, 14 Jun 2001 18:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264111AbRFNWEC>; Thu, 14 Jun 2001 18:04:02 -0400
Received: from beppo.feral.com ([192.67.166.79]:24590 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S264108AbRFNWDt>;
	Thu, 14 Jun 2001 18:03:49 -0400
Date: Thu, 14 Jun 2001 15:03:00 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Riley Williams <rhw@MemAlpha.CX>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Gigabit Intel NIC? - Intel Gigabit Ethernet Pro/1000T
In-Reply-To: <20010614145221.H17427@one-eyed-alien.net>
Message-ID: <20010614145802.Q22077-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Matthew Dharm wrote:

> I know, jumping in at this late-stage is bad form... but if we're talking
> about the Intel 82543GC Gigabit MAC, why doesn't someone just use the
> FreeBSD if_wx.c driver as a starting point?
>
> It took me a while to find, as they refer to it as the LIVENGOOD instead of
> the 82543, but the PCI ProductID values seem to match...
>
> Matt

Let me stir the pot a bit and report that the Intel driver folks (yes, they
*do* have them) claim to have a driver that blows the doors off of wx. I told
them that with their access to docs and to actual chip engineers that if it
*didn't* do so, they really were in sad shape.

-matt



