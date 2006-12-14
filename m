Return-Path: <linux-kernel-owner+w=401wt.eu-S932875AbWLNR1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbWLNR1T (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWLNR1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:27:19 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37002 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875AbWLNR1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:27:18 -0500
Date: Thu, 14 Dec 2006 18:20:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061214130704.GB17565@redhat.com>
Message-ID: <Pine.LNX.4.61.0612141818430.12730@yvahk01.tjqt.qr>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
 <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
 <4580E37F.8000305@mbligh.org> <20061214130704.GB17565@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The Ubuntu feisty fawn mess was a dangerous warning bell of where we're
> > going. If we don't stand up at some point, and ban binary drivers, we
> > will, I fear, end up with an unsustainable ecosystem for Linux when
> > binary drivers become pervasive. I don't want to see Linux destroyed
> > like that.
>
>Thing is, if kernel.org kernels get patched to disallow binary modules,
>whats to stop Ubuntu (or anyone else) reverting that change in the
>kernels they distribute ?  The landscape doesn't really change much,
>given that the majority of Linux end-users are probably running
>distro kernels.

And even if the distros don't change it (all legal issues aside), there's
probably some free user who repacks the distro kernel.

	/me eyeballs myself...


	-`J'
-- 
