Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSKSA2C>; Mon, 18 Nov 2002 19:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSKSA2C>; Mon, 18 Nov 2002 19:28:02 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:36625 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S265339AbSKSA2C>;
	Mon, 18 Nov 2002 19:28:02 -0500
Date: Mon, 18 Nov 2002 17:34:57 -0700
From: Val Henson <val@nmt.edu>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
Message-ID: <20021119003457.GB28304@boardwalk>
References: <3DD9688F.8030202@pobox.com> <Pine.LNX.4.33.0211181755560.24054-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211181755560.24054-100000@router.windsormachine.com>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 05:57:34PM -0500, Mike Dresser wrote:
> 
> Took the card out, tried another, 10ec:8139 as expected.
> 
> Put the old card back in, didn't come up in BIOS or lspci.  Pulled the
> card out, put it back in, comes up as 10ec:8139.
> 
> I suspect there's something flaky about this card :D

In the past, I've seen similar problems caused by a not-completely
seated PCI card.  If the problem goes away when you take the card out
and put it back, I would suspect poor seating rather than a bad card.

> So yeah, ignore all the pci_id stuff, this card is just fubar :)

Don't toss it out just yet. :)

-VAL
