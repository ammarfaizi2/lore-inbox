Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWEXOa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWEXOa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWEXOa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:30:28 -0400
Received: from relay03.pair.com ([209.68.5.17]:35850 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932319AbWEXOa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:30:28 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 24 May 2006 09:30:23 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "D. Hazelton" <dhazelton@enter.net>
cc: Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <200605240042.46288.dhazelton@enter.net>
Message-ID: <Pine.LNX.4.64.0605240925510.15931@turbotaz.ourhouse>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
 <200605232324.20876.dhazelton@enter.net> <9e4733910605232121s259e97fdu755e1f2762026e5f@mail.gmail.com>
 <200605240042.46288.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, D. Hazelton wrote:

> And as you note, licensing is an issue. However, as the kernel is GPL I might
> use DRM as an information source and write that code over again to sidestep
> any licensing issues. (I really don't want to piss off the MIT or BSD people)

While licensing is obviously entirely up to you (as the author), I 
wouldn't worry too much about using the GPL / copyleft for your software 
in this case. I know there are a lot of BSD developers that would be happy 
to replace every line of GPL-licensed code with BSD-licensed code, but 
given that the BSD license has around 5% penetration versus 
some-number-around-80% for the GPL, I think GPL code in a BSD system is 
kind of a reality at this point. It might be more of a concern to me (in my work) if I 
thought that the GPL was restrictive.

Remember that the GPL doesn't even apply to the end-user until they want 
to make a copy of your original or their derivitive work. Also remember 
that GNOME and KDE are both under (L)GPL licensing.

> DRH

Cheers,
Chase
