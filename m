Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUHEWYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUHEWYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268016AbUHEWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:24:46 -0400
Received: from digitalimplant.org ([64.62.235.95]:32130 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S268015AbUHEWVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:21:18 -0400
Date: Thu, 5 Aug 2004 15:21:03 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status with pmdisk/swsusp merge ?
In-Reply-To: <1091679494.5225.186.camel@gaston>
Message-ID: <Pine.LNX.4.50.0408051517141.6736-100000@monsoon.he.net>
References: <1091679494.5225.186.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Aug 2004, Benjamin Herrenschmidt wrote:

> What is the status with those patches ?
>
> I have some additional stuff to drop on top of it, including the basic
> PPC support, some renumbering of the states as discussed earlier, some
> driver fixes etc.... but at this point, I feel it would be more handy
> to get those in only after Patrick core changes have been merged with
> Linus. Do we wait for 2.6.9 to open ?

I intend to try and merge my tree with Linus once he releases 2.6.8,
modulo any bugs that crop up between now and then. Feel free to send me
the patches to fix up ppc before then, and I will merge them as well.

As far as the device power management stuff goes, I'm wading through the
discussion right now..


	Pat
