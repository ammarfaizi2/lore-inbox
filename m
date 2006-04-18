Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDRJ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDRJ53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDRJ53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:57:29 -0400
Received: from [205.233.219.253] ([205.233.219.253]:14050 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750722AbWDRJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:57:28 -0400
Date: Tue, 18 Apr 2006 05:48:28 -0400
From: Jody McIntyre <scjody@modernduck.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Dan Dennedy <dan@dennedy.org>, linux1394-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
Message-ID: <20060418094828.GP5346@conscoop.ottawa.on.ca>
References: <20060406224706.GD7118@stusta.de> <44374FC0.3070507@s5r6.in-berlin.de> <200604081218.24544.dan@dennedy.org> <443813C4.9090000@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443813C4.9090000@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 09:49:24PM +0200, Stefan Richter wrote:
> 
> Then I suggest we adjust the date in 
> Documentation/feature-removal-schedule.txt (increment by 1 year?) and 
> also list kino and gstreamer as affected application programs there.

Done.

Cheers,
Jody

> 
> It appears from grep'ing through the sources of Ekiga 2.0.1 that it does 
> not access (lib)raw1394 by itself.
> -- 
> Stefan Richter
> -=====-=-==- -=-- -=---
> http://arcgraph.de/sr/
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
