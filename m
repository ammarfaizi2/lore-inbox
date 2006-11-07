Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754102AbWKGHUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbWKGHUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbWKGHUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:20:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52106 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754102AbWKGHUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:20:13 -0500
Date: Tue, 7 Nov 2006 08:20:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       nfsv4@linux-nfs.org
Subject: Re: Poor NFSv4 first impressions
Message-ID: <20061107072000.GC21655@elf.ucw.cz>
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With this patch, I can run just great with NFSv4 home dir (etc)
> mounts; without, I get the symptom of many 0-byte temporary/lock files
> being created and often the inability to create files (!). Be sure to
> allow callback delegation connections in through your firewall for the
> extra performance ;-) .
> 
> Maybe it's too late for these fixes 2.6.19, but they should certainly
> make 2.6.19.1 IMHO.

If they are good enough for 2.6.19.1, they should _definitely_ go into
2.6.19.


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
