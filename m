Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVILWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVILWA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVILWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:00:57 -0400
Received: from [205.233.219.253] ([205.233.219.253]:420 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S932281AbVILWA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:00:56 -0400
Date: Mon, 12 Sep 2005 17:58:55 -0400
From: Jody McIntyre <scjody@steamballoon.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Ben Collins <bcollins@debian.org>, Steve Kinneberg <kberg@pobox.com>
Subject: Re: eth1394 and sbp2 maintainers
Message-ID: <20050912215855.GQ26223@conscoop.ottawa.on.ca>
References: <43232875.4040702@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43232875.4040702@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 08:39:49PM +0200, Stefan Richter wrote:
> Hi all,
> 
> the MAINTAINERS list of Linus' tree is still listing eth1394 and sbp2 as 
> orphaned. This is certainly not correct for sbp2. Is it for eth1394?

eth1394: I emailed Steve Kinneberg, the last person to do any serious
work on the driver,  before I made this change, and he's OK with that.
If someone else wants to take it, I suggest they submit a patch.

> Ben, I remember you wanted to have your contact added back in, at least 
> for sbp2. In case this should not be true anymore, I'd volunteer for 
> sbp2 maintenance.

Ben is currently listed for ieee1394, ohci1394, and raw1394.  Someone
should take sbp2 now that it's being worked on actively again, but I'll
leave that up to you two.

Cheers,
Jody

> -- 
> Stefan Richter
> -=====-=-=-= =--= -=-=-
> http://arcgraph.de/sr/

-- 
