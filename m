Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbTEESaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbTEESaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:30:19 -0400
Received: from windsormachine.com ([206.48.122.28]:33545 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S261198AbTEESaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:30:18 -0400
Date: Mon, 5 May 2003 14:42:47 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ABIT IC7-G
In-Reply-To: <Pine.LNX.4.53.0305051355490.1391@chaos>
Message-ID: <Pine.LNX.4.33.0305051400090.26862-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Richard B. Johnson wrote:

> ABIT IC7-G Main Boards and Linux
>
> Warning! These boards are being shipped without the On-board
> Intel CSA Gigabit LAN that is clearly specified in the user-
> manual, and in the advertisement on the Web-Page.

I see in the picture they have that they put the network connector in a
nonstandard place.

What is it shipping with instead?

> Yes, I got ripped off. Also, the AGP slot will not work properly
> with the normal AGP video boards like NVIDA GForce, etc. You need
> special 1.5V or 0.8V AGP cards (page 2-15 in the manual). The 3.3V
> AGP cards will seem to work, but the machine will just STOP, for
> no apparent reason at all.

Indeed, the 845/850/875/7205? are all .8/1.5v only.  It's been that way
for a number of years.  Wouldn't be surprised to find out other chipsets
are like that either, 3.3V is rather old.

Don't use a 3.3V card, this violates the chipset specs, and you're lucky
you didn't burn out the card and/or board.  ASUS puts a red warning led
on the motherboard.  I'm surprised your 3.3V card fit, most are keyed so
you can't put them in the wrong slot.

Mike

