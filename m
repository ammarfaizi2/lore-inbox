Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWJBNlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWJBNlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWJBNlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:41:15 -0400
Received: from [69.90.0.18] ([69.90.0.18]:15510 "EHLO mtl.rackplans.net")
	by vger.kernel.org with ESMTP id S932324AbWJBNlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:41:10 -0400
Date: Mon, 2 Oct 2006 09:41:02 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
X-X-Sender: gmack@mtl.rackplans.net
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
cc: Michael Obster <lkm@obster.org>, linux-kernel@vger.kernel.org
Subject: Re: OT: linux-kernel list and greylisting
In-Reply-To: <200609281946.11845.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.64.0610020940010.31384@mtl.rackplans.net>
References: <451BFF6F.2050602@obster.org> <200609281946.11845.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you absolutely need to graylist (I have my doubts about it's 
effectiveness) then whitelist vger.kernel.org.

Gerhard


On Thu, 28 Sep 2006, Mariusz Kozlowski wrote:

> Date: Thu, 28 Sep 2006 19:46:11 +0200
> From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> To: Michael Obster <lkm@obster.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: OT: linux-kernel list and greylisting
> 
> Hi,
> 
> > anyone here who has experience with greylisting and the linux-kernel
> > list? I want to configure greylisting on my server but I don't know if
> > this setting is compatible with the list here.
> > What I want to avoid is a massive bounce because of that! So please give
> > me feedback, if greylisting is a problem for the list.
> 
> Greylisting relayed traffic is useless. Greyslisting is also expensive (delays 
> and bounces) so probably that's not what you want. Anyway if you know what 
> you are doing ;-) take a look at this:
> 
> http://aisk.tuxland.pl/os-fp-vs-spam-src.html
> 
> OS based greylisting is a compromise. Gives great results with minimal costs 
> to most of incoming traffic.
> 
> Regards,
> 
> 	Mariusz Kozlowski
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
