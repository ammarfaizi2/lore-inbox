Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144258AbRA1WIG>; Sun, 28 Jan 2001 17:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144250AbRA1WH7>; Sun, 28 Jan 2001 17:07:59 -0500
Received: from datafoundation.com ([209.150.125.194]:43025 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S143948AbRA1WHp>; Sun, 28 Jan 2001 17:07:45 -0500
Date: Sun, 28 Jan 2001 17:07:33 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: Mike Pontillo <mike_p@polaris.wox.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Support for 802.11 cards?
In-Reply-To: <Pine.LNX.4.21.0101281344040.12805-100000@polaris.wox.org>
Message-ID: <Pine.LNX.4.30.0101281704050.2343-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Mike Pontillo wrote:

> 	I was wondering what 802.11 PCI cards anyone knows of that run
> under Linux-2.4. (or 2.2 for that matter)

I _think_ a good many of the 802.11 wireless ISA and PCI cards are just
bus to PCMCIA adapters, so it would be a question of whether or not the
PCMCIA card is supported and if the bridge is supported.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
