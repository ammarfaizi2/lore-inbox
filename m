Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266614AbUGPRMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUGPRMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUGPRKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:10:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19639 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266603AbUGPRKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:10:38 -0400
Date: Fri, 16 Jul 2004 19:00:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Volker Braun <volker.braun@physik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040716170052.GC8264@openzaurus.ucw.cz>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <pan.2004.07.14.23.28.53.135582@physik.hu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.07.14.23.28.53.135582@physik.hu-berlin.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And, if I would shine
> > a bright light on the screen, I could make out text on it.  In other
> > words, the backlight was off but it was still displaying stuff.
> 
> I cannot reproduce that (T41), but maybe I'm looking at the wrong angle or
> your eyes are better. In any case I understand that this image is very
> faint.
> 
> I'm not sure whether this is actually part of the problem. The
> liquid crystals might just keep their current orientation, or there might
> be some residual charge in the driver circuit. Do you want to take your
> display apart and check with a voltmeter? I dont't :-)

If it is still there after half an hour, its certainly part of the problem.
LCD crystals loose the orientation in seconds, IIRC.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

