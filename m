Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWDWW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWDWW1e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDWW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 18:27:34 -0400
Received: from tim.rpsys.net ([194.106.48.114]:5608 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932085AbWDWW1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 18:27:33 -0400
Subject: Re: [PATCH] [LEDS] Amstrad Delta LED support
From: Richard Purdie <rpurdie@rpsys.net>
To: Jonathan McDowell <noodles@earth.li>, Andrew Morton <akpm@osdl.org>
Cc: Ben Dooks <ben@fluff.org.uk>, linux-kernel@vger.kernel.org,
       e3-hacking@earth.li
In-Reply-To: <20060423221453.GU7570@earth.li>
References: <20060422130823.GP7570@earth.li>
	 <20060423123850.GA18923@home.fluff.org>  <20060423221453.GU7570@earth.li>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 23:27:18 +0100
Message-Id: <1145831239.6744.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-23 at 23:14 +0100, Jonathan McDowell wrote:
> On Sun, Apr 23, 2006 at 01:38:50PM +0100, Ben Dooks wrote:
> > On Sat, Apr 22, 2006 at 02:08:23PM +0100, Jonathan McDowell wrote:
> > > [Which tree should I be trying to submit this to? The patch is
> > > against and works fine with 2.6.17-rc2]
> > I prefer the following PM defines, so there is only one block of
> > CONFIG_PM
> 
> Seems reasonable; leds-spitz has the two blocks and that's what I'd used
> as inspiration. Revised version below.
> 
> 
> 
> Use the new LED infrastructure to support the 6 LEDs present on the
> Amstrad Delta.
> 
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
Acked-By: Richard Purdie <rpurdie@rpsys.net>



