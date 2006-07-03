Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWGCJCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWGCJCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWGCJCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:02:15 -0400
Received: from sd291.sivit.org ([194.146.225.122]:34319 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1750940AbWGCJCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:02:14 -0400
Subject: Re: [RFC] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, khali@linux-fr.org,
       linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org,
       johannes@sipsolutions.net, chainsaw@gentoo.org
In-Reply-To: <20060703065628.GA21113@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch>
	 <20060702201415.791c6eb2.akpm@osdl.org>  <20060703065628.GA21113@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 03 Jul 2006 11:02:11 +0200
Message-Id: <1151917331.10711.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 03 juillet 2006 à 08:56 +0200, Michael Hanselmann a écrit :
> Hello Andrew
> 
> On Sun, Jul 02, 2006 at 08:14:15PM -0700, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 00:26:49 +0200
> > Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> 
> > > Below you find the latest revision of my AMS driver.
> 
> > I was about to merge the below, then this comes along.  Now what?
> 
> > From: Stelian Pop <stelian@popies.net>
> 
> > This driver provides support for the Apple Motion Sensor (ams), which
> > provides an accelerometer and other misc.  data.  Some Apple PowerBooks
> 
> I just noticed yesterday that Stelian sent a patch to lkml in May. My
> work is based on his separate driver from his website.
> 
> Given the fact that my driver includes all of his functionality and that
> replacing his with mine later in the process would mean to remove whole
> files again, I'd suggest to wait until I've fixed the outstanding issues
> (as seen in this thread) and then to merge mine.

I have no problems with this approach. I'll take a look at your patch
ASAP.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

