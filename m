Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWDRJzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWDRJzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDRJzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:55:23 -0400
Received: from [205.233.219.253] ([205.233.219.253]:9442 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750764AbWDRJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:55:15 -0400
Date: Tue, 18 Apr 2006 05:45:40 -0400
From: Jody McIntyre <scjody@modernduck.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Dan Dennedy <dan@dennedy.org>, linux1394-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
Message-ID: <20060418094540.GO5346@conscoop.ottawa.on.ca>
References: <20060406224706.GD7118@stusta.de> <44374FC0.3070507@s5r6.in-berlin.de> <200604081218.24544.dan@dennedy.org> <443813C4.9090000@s5r6.in-berlin.de> <443814AA.1040707@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443814AA.1040707@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 09:53:14PM +0200, Stefan Richter wrote:

> We should have added such warnings already to the kernel at the moment 
> when the two ioctls went into feature-removal-schedule.txt.

We originally decided just to put it into libraw1394.  I don't see the
point of having it in two places, but I suppose it couldn't hurt.. I'll
take a patch :)

Cheers,
Jody

> -- 
> Stefan Richter
> -=====-=-==- -=-- -=---
> http://arcgraph.de/sr/

-- 
