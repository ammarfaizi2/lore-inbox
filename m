Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbTFNBeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265601AbTFNBeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:34:06 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:21391 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id S265600AbTFNBeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:34:01 -0400
Date: Fri, 13 Jun 2003 21:47:47 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [RFC PATCH] Add lm78 sensor chip support (2.5.70)
Message-ID: <20030614014747.GA19218@earth.solarsys.private>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Sensors <sensors@stimpy.netroedge.com>
References: <20030608223334.GC30962@earth.solarsys.private> <20030613231135.GE2258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613231135.GE2258@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <greg@kroah.com> [2003-06-13 16:11:35 -0700]:
> On Sun, Jun 08, 2003 at 06:33:34PM -0400, Mark M. Hoffman wrote:
> > This patch vs. 2.5.70 adds support for LM78, LM78-J, and LM79 sensors
> > chips based on lm_sensors project CVS.  This works on one of my boards.
> 
> Do you want me to add this to the kernel tree?  Sorry I missed this in
> the last round of i2c patches I sent out.

I was hoping to get some feedback w.r.t. the conversion routines...
but I guess silence is consent.  Please pass this on in the next round.
No worries, btw.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

