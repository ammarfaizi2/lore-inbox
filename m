Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUEDOBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUEDOBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEDOBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:01:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6123 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264377AbUEDOAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:00:31 -0400
Date: Mon, 3 May 2004 15:51:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, postmaster@vger.kernel.org
Subject: Re: hda active and hdb sleep?
Message-ID: <20040503135145.GE1188@openzaurus.ucw.cz>
References: <Pine.LNX.4.44.0405022150410.4526-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405022150410.4526-100000@poirot.grange>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As soon as I issue hdparm -Y /dev/hdb I get errors on hda and it doesn't
> seem to be possible to have hdb in sleep and hfa active. I think, those
> power-states are purely per-device, aren't they. It's a VIA ProSavage
> KM133 chipset. 2.6.3 kernel at the moment.

Does -y work?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

