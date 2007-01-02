Return-Path: <linux-kernel-owner+w=401wt.eu-S1755248AbXABOTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXABOTv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbXABOTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:19:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59611 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755248AbXABOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:19:50 -0500
Date: Tue, 2 Jan 2007 15:18:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Message-ID: <20070102141847.GA4086@elf.ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612291718.34494.david-b@pacbell.net> <20070101205521.GB4901@elf.ucw.cz> <200701011327.33771.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701011327.33771.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Should it instead say that's an (obviously unchecked) error?
> > 
> > Saying it is an error would be okay by me. (Or "Behaviour of these calls for
> > GPIOs that can't be safely accessed without sleeping is undefined.").
> 
> See the appended doc patch ... better?

Yes, thanks.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
