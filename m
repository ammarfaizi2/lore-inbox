Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSKRTgA>; Mon, 18 Nov 2002 14:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSKRTea>; Mon, 18 Nov 2002 14:34:30 -0500
Received: from poup.poupinou.org ([195.101.94.96]:1314 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S264766AbSKRT0M>;
	Mon, 18 Nov 2002 14:26:12 -0500
Date: Mon, 18 Nov 2002 20:32:48 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
Message-ID: <20021118193248.GE27595@poup.poupinou.org>
References: <3DD8B521.19184544@eyal.emu.id.au> <3DD931BA.9040407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD931BA.9040407@pobox.com>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 01:30:18PM -0500, Jeff Garzik wrote:
> Eyal Lebedinsky wrote:
> 
> >I recently got a local (Australian, NetComm) NIC that uses a 8139D.
> >The standard 8139too seems to work with it but I wonder if I can
       ^^^^^^^^^^^^^^^^

> >get something more out of a driver that has extra support.
> 
> [...]
> 
> >Anyone knows the difference between the 8139C and 8139D?
> 
> 
> 
> At the driver level, there should not be appreciable differences between 
> the two chips.  8139C+ is the super-cool tulip-like chip from RealTek 
> with all the speed and features.  8139D is just a small incremental 
> revision of the chip.  It does add a few features, but none that would 
> affect performance or stability (positively or negatively).
> 
> RealTek's 8139C+, and it's GigE cousin 8169 are really nice.  I hope 
> RealTek finds a lot of customers for these chips, because so far they 
> are both solid, fast, and feature-full.
> 

Do we have to assume that Eyal Lebedinsky should use 8139cp driver
instead of 8139too ?

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
