Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTHaNQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTHaNQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:16:09 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45241 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261947AbTHaNQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:16:06 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831025659.GA18767@work.bitmover.com>
References: <20030830230701.GA25845@work.bitmover.com>
	 <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
	 <20030831013928.GN24409@dualathlon.random>
	 <20030831025659.GA18767@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 14:15:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 03:56, Larry McVoy wrote:
> I'm pretty convinced we can't solve the problem at our end.  Maybe we can

For bursts of traffic you can't.

> but I'm voting for throwing another T1 at the problem, we'll try working

or switch to ATM ;)

> with the ISP suggested solution of trunking them and rate limiting at
> their end and if that doesn't work then we'll split them and use one for
> bkbits.net and other bitmover related TCP traffic and use the other one
> for phones.

Fractioning the line is also doable but less flexible with some kit. 


