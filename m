Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbTGNMkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270598AbTGNMiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:38:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56593 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270608AbTGNMag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:30:36 -0400
Date: Sat, 5 Jan 2002 12:13:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] fbdev and power management
Message-ID: <20020105111340.GA2254@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org> <1057750557.514.22.camel@gaston> <20030709151032.A22612@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709151032.A22612@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm slightly concerned by this.  There are a growing amount of drivers
> in 2.5 which are being made to work with the existing power management
> system.  This "new" system seems to have been hanging around for about
> 4 months now with no visible further work, presumably so that a paper
> can be presented before its release.

I believe it is bad idea to change driver
model again in 2.6.x-pre. I believe current
solution is pretty much okay.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

