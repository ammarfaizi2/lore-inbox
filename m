Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSLaAks>; Mon, 30 Dec 2002 19:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSLaAks>; Mon, 30 Dec 2002 19:40:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265787AbSLaAkr>;
	Mon, 30 Dec 2002 19:40:47 -0500
Date: Mon, 30 Dec 2002 16:49:11 -0800
From: Dave Olien <dmo@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa1: compile error in DAC960.c
Message-ID: <20021230164911.A12919@build.pdx.osdl.net>
References: <20021226010605.GA4223@dualathlon.random> <3E0A8685.5CAE1CE0@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E0A8685.5CAE1CE0@eyal.emu.id.au>; from eyal@eyal.emu.id.au on Thu, Dec 26, 2002 at 03:33:09PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a patch that works at the URL:

	http://www.osdl.org/archive/dmo/DAC960_2.4.20aa1/

I originally developed it for the aa1 patch.  But it works
on the newer aa patches as well.

On Thu, Dec 26, 2002 at 03:33:09PM +1100, Eyal Lebedinsky wrote:
> As is the case in the last few -aa patches, we still have the
> problem in drivers/block/DAC960.c.
> 
> I suggest that someone who knows fixes it, or else remove it
> from the -aa collection.
> 
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
