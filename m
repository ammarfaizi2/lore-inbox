Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTJZUeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 15:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTJZUeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 15:34:16 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:27776
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263645AbTJZUeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 15:34:14 -0500
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerMac 8500 (summary)
Message-Id: <E1ADrax-0000rF-00@penngrove.fdns.net>
Date: Sun, 26 Oct 2003 12:34:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[To reduce noise, i've replied personally to specific points not
of general interest to the list.  Here's an (updated) summary]

Yeah, much of what was in the earlier summary has been cleared up.  

I am pleased to report that aside from the SWIM3 and MESH problems
for which i have workaround patches, i think my PPC issues for 2.6.0
have been mostly resolved.

The two remaining annoyances on the PowerMac 8500 are losing sync
switching from X to the framebuffer console and the slab corruptions 
warnings when ejecting a CDROM.  

One not specific to PPC is that it would be better if 'bootlogd' 
didn't *silently* wait for RAID5 to finish parity reconstruction.

Thanks for the hard work and suggestions!

	 		    -- JM
