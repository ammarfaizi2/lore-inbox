Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUCZM0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbUCZM0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:26:33 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:56284 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264026AbUCZM0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:26:32 -0500
Date: Fri, 26 Mar 2004 13:26:31 +0100
From: bert hubert <ahu@ds9a.nl>
To: Robert Schwebel <robert@schwebel.de>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326122631.GA25665@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Robert Schwebel <robert@schwebel.de>,
	David Brownell <david-b@pacbell.net>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326121928.GC16461@pengutronix.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 01:19:28PM +0100, Robert Schwebel wrote:

> You need such an .inf file on the windows side; M$ has a template where
> you simply need to insert your vendor/device ID and other stuff. I'm not
> sure about the license for these files, so I don't know if it is allowed
> to distribute them. 

And that .inf describes 'Linux'? No matter what the license is, you can link
to it and instruct people on how to change it. You could even show pieces of
the .inf with the linux data filled in ('fair use').

I ask about this because I know that to get adequate testing coverage,
experimenting with this code should be as easy as possible. Something like
'visit this URL and paste in the following: (...) and now do such and such
in windows and you should be set'. 

I'll happily write this for you if you provide the pointers.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
