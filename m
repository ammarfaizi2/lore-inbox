Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVDZVQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVDZVQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVDZVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 17:16:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60298 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261788AbVDZVQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 17:16:11 -0400
Date: Tue, 26 Apr 2005 23:15:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Adam Belay <ambx1@neo.rr.com>,
       Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com
Subject: Re: [linux-usb-devel] Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426211542.GH20109@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425205536.GF27771@neo.rr.com> <20050425210631.GE3906@elf.ucw.cz> <200504260644.03627.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504260644.03627.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes. (Actually I'm not sure if PMSG_FREEZE or PMSG_SUSPEND is right
> > thing to do for suspend.)
> 
> Until they have different values, it's a moot point isn't it?

They already have different values in my and SuSE trees, and I plan to
propagate that upstream very soon after 2.6.12. Until then... yes its
moot.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
