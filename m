Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271631AbTGRJuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271602AbTGRJsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:48:33 -0400
Received: from [66.212.224.118] ([66.212.224.118]:22798 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271596AbTGRJlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:41:39 -0400
Date: Fri, 18 Jul 2003 05:45:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, Danek Duvall <duvall@emufarm.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O6.1int
In-Reply-To: <20030718114034.B8542@ss1000.ms.mff.cuni.cz>
Message-ID: <Pine.LNX.4.53.0307180537130.6844@montezuma.mastecende.com>
References: <200307171635.25730.kernel@kolivas.org> <20030717080436.GA16509@lorien.emufarm.org>
 <20030718070749.GA12466@lorien.emufarm.org> <20030718114034.B8542@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Rudo Thomas wrote:

> > I did discover under O6.1int that I could make xmms block indefinitely
> > when opening a window, with fvwm's wire frame manual placement, which I
> > hadn't ever noticed before, but I'm not sure if that's because it
> > actually wasn't there before, or I just placed the windows more quickly.
> 
> The latter, I think. I had similar problems under kwin when moving windows with
> "display window contents while moving" unset. I don't seem to be able to
> reproduce it now (2.6.0-t1), though.

Side note i can actually wiggle a mozilla window around a 2000x2000@24bit 
display with make -j2 going and 'display window contents while moving' now in 
KDE3 w/ kwin. I normally have it on wireframe. X server is the XFree86 
radeon driver w/ a 9100 and 128Mb of video memory, system is dual 400, 
512Mb ram.

-- 
function.linuxpower.ca
