Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbSKRWnF>; Mon, 18 Nov 2002 17:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSKRWnF>; Mon, 18 Nov 2002 17:43:05 -0500
Received: from windsormachine.com ([206.48.122.28]:31757 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S266977AbSKRWnE>; Mon, 18 Nov 2002 17:43:04 -0500
Date: Mon, 18 Nov 2002 17:50:01 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
In-Reply-To: <3DD96C98.7020508@pobox.com>
Message-ID: <Pine.LNX.4.33.0211181747170.18695-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jeff Garzik wrote:

> Mike Dresser wrote:
>
> > I'll try another card, and get back to you, just in case it's a
> > partially fubar card.
>
> FWIW I have seen tons of 8139s that work fine but have invalid PCI
> IDs... the price of being a US$0.50 chip I guess :)
>
> So I doubt it's a fubar card...

Just tried another 8139D card, same make, and it shows up as a 10ec:8139
instead of the 00ec.  Bad bit, indeed.

So I've got a card that has a wrong PCI id, I wonder what Windows would do
if i installed it there.  I wonder if I have more of these to test.  Found
another one.  I'll test THIS one too :)

> 8139C+ is, in CVS lingo, a branch.  8139D has -none- of the 8139C+
> functions...

Thanks :)  How about a note in the C+ things that D isn't higher than C+
then.

Mike

