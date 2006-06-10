Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWFJP2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWFJP2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWFJP2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:28:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32654 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030434AbWFJP2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:28:25 -0400
Date: Sat, 10 Jun 2006 17:27:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hui Zhou <hzhou@hzsolution.net>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
Subject: Re: Frustrating Random Reboots, seeking suggestions
Message-ID: <20060610152741.GA2042@elf.ucw.cz>
References: <20060609145757.GB1640@smtp.comcast.net> <Pine.LNX.4.64.0606091058320.4969@turbotaz.ourhouse> <20060610023719.GA10857@smtp.comcast.net> <200606101052.05212.ioe-lkml@rameria.de> <20060610113712.GA2388@smtp.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610113712.GA2388@smtp.comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >YES: Check for heat and power problems.
> >
> >	If you are brave you could try some cpuburn variant to put the heat 
> >	to the maximum.
> >
> >	WARNING: This could kill your CPU and might void your warranty, 
> >		since this is not "normal use" of your CPU :-)
> 
> No, I am not that brave. :) However, I am now faily certain it is not 
> heat problem. After relinked with a new libmpeg binary, it hasn't 
> rebooted yet (8+hours). Any possibility that some binary code can 

Wrong answer. If you are fairly sure it is not heat problem, try some
cpuburn. See http://www.livejournal.com/~pavelmachek -- you are
unlikely to physicaly damage anything.
								Pavel
-- 
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
