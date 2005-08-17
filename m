Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVHQDx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVHQDx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVHQDx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:53:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:62147 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750813AbVHQDx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:53:27 -0400
Subject: Re: [PATCH] [Fwd: Console locking and blanking]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1124250271.5764.76.camel@localhost.localdomain>
References: <1124242875.8848.10.camel@gaston>
	 <1124249381.8848.19.camel@gaston>
	 <1124250271.5764.76.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 13:51:02 +1000
Message-Id: <1124250664.8849.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 23:44 -0400, Steven Rostedt wrote:
> On Wed, 2005-08-17 at 13:29 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-08-17 at 11:41 +1000, Benjamin Herrenschmidt wrote:
> > 
> > > (I'm blind and I use a braille display. I use those functions to blank 
> > > my laptop's screen so people don't read it, and hopefully to conserve 
> > > power.)
> 
> At the OLS I learned that the backlight of a laptop (when the screen is
> black, but still glows) actually spends more wattage than when the
> screen is lit.  So, unless you actually turn the laptop display off,
> switching it to black will actually burn the battery quicker.

Actually, it's not the backlight. The backlight definitely eats less
power when off. The panel itself, however, at least some of them afaik,
will use a bit more power for opaque pixels than for transparent pixels.

Ben.


