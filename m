Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRAaU7D>; Wed, 31 Jan 2001 15:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132644AbRAaU6x>; Wed, 31 Jan 2001 15:58:53 -0500
Received: from anime.net ([63.172.78.150]:42759 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S132438AbRAaU6l>;
	Wed, 31 Jan 2001 15:58:41 -0500
Date: Wed, 31 Jan 2001 12:58:17 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Scott Laird <laird@internap.com>
cc: George <greerga@entropy.muc.muohio.edu>,
        Peter Samuelson <peter@cadcamlab.org>,
        Bernd Eckenfels <inka-user@lina.inka.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <Pine.LNX.4.31.0101311243340.13278-100000@lairdtest1.internap.com>
Message-ID: <Pine.LNX.4.30.0101311256400.19040-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Scott Laird wrote:
> Where do cards with PCI-PCI bridges, like multiport PCI ethernet cards,
> fit into this?  I can easily add 3 or 4 extra busses into a box just by
> grabbing a couple extra Intel dual-port Ethernet cards.

I loaded a PC with quad-tulip cards once and the result was not pretty.
IRQs all over the place, and /proc/pci shat all over itself too

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
