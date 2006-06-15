Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWFOUs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWFOUs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWFOUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 16:48:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25510 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932498AbWFOUs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 16:48:26 -0400
Date: Thu, 15 Jun 2006 22:47:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Daniel Drake <dsd@gentoo.org>, Jiri Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
Message-ID: <20060615204738.GD1849@elf.ucw.cz>
References: <20060607140045.GB1936@elf.ucw.cz> <20060607160828.0045e7f5@griffin.suse.cz> <20060607141536.GD1936@elf.ucw.cz> <4486FD2F.8040205@gentoo.org> <20060608070525.GE3688@elf.ucw.cz> <4489ECD0.1030908@gentoo.org> <20060609223804.GB3252@elf.ucw.cz> <20060615201024.GD32582@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615201024.GD32582@tuxdriver.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Which operation is the one which stops the interference, the enable or 
> > > the disable?
> > 
> > Disable alone was not enough to stop interference.
> 
> I'm going to drop this patch for now, in the hopes that with Daniel's
> ZyDas contacts you can devise a more palatable solution.

I'd actually like you to keep it, it does not seem ZyDas contacts are
going anywhere.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
