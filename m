Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUCZKiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbUCZKiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:38:13 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:21452 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264002AbUCZKiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:38:12 -0500
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
From: David Woodhouse <dwmw2@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <40636295.7000008@pacbell.net>
References: <20040325221145.GJ10711@pengutronix.de>
	 <40636295.7000008@pacbell.net>
Content-Type: text/plain
Message-Id: <1080297466.29835.144.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 26 Mar 2004 10:37:47 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 14:52 -0800, David Brownell wrote:
> (Although I personally would prefer that Microsoft adopt vendor-neutral
> protocols, instead of pushing the rest of the industry to adopt things
> that are MSFT-biased ... for some reason, they haven't listened to almost
> anyone on such topics.  Oh well.  ;)

Out of interest -- have they (or has anyone else) invented a 'file
system' USB device yet? For exporting some file systems, pretending to
be a block device really isn't very useful.

-- 
dwmw2

