Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTIGReQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTIGReP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:34:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:22251 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263401AbTIGRds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:33:48 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Robert Schwebel <robert@schwebel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20030907130034.GT14436@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de>
	 <20030907124251.GC5460@pengutronix.de>  <20030907130034.GT14436@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062955895.16972.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 07 Sep 2003 18:31:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 14:00, Adrian Bunk wrote:
> > Ack. Same with for example Geode. And the subarchs might have different
> 
> It seems the Geode support isn't fully merged in 2.6?

Geode is just another PC, well at least in software. In hardware its
rather different and uses a lot of clever magic.

