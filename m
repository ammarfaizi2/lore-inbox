Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbVLONky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbVLONky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbVLONkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:40:53 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:26578 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1422716AbVLONkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:40:53 -0500
Date: Thu, 15 Dec 2005 08:40:47 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
Message-ID: <20051215134047.GA12327@jupiter.solarsys.private>
References: <20051215043212.GA4479@jupiter.solarsys.private> <21d7e9970512142355l782396f6s385df3c1b6b8b16f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970512142355l782396f6s385df3c1b6b8b16f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave:

* Dave Airlie <airlied@gmail.com> [2005-12-15 18:55:37 +1100]:
> > >     [drm] fix radeon aperture issue
> >
> > With this one applied, my machine locks up tight just after starting the
> > Xserver.  Some info (dmesg, lspci, config) is here:
> 
> Can you give me an Xorg.0.log and /etc/X11/xorg.conf
> 
> I've got the same card here and it seems to work for me .. so maybe
> its a configuration issue..

I've added both files here:

http://members.dca.net/mhoffman/lkml-20051214/

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

