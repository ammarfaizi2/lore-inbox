Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750775AbWFEXNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWFEXNR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFEXNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:13:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25009 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750775AbWFEXNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:13:16 -0400
Date: Tue, 6 Jun 2006 01:12:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux UWB and Wireless USB project
Message-ID: <20060605231233.GJ3469@elf.ucw.cz>
References: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >> UWB is a high-bandwidth, low-power, point-to-point radio
> >> technology using a wide spectrum (3.1-10.6HGz).  It is
> >
> >How much power is low power?
> 
> For what I know (and I could be wrong) max is around -40dBm/MHz 
> in the US. I am no expert in the nitty-gritty radio details, but 
> I've been told that is 3000 times less emissions than a common 
> cellphone, around .1 uW? [this is where my knowledge about radio
> *really* fades].

Common cellphones are 2W, iirc; (so it would be ~1mW) but I was more
interested in system power consumption. WIFI is too power intensive
for a cellphone (mostly). Is this designed to go into cellphones?
notebooks?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
