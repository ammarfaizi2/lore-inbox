Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTH0D2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTH0D2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:28:10 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:61893
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S263081AbTH0D2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:28:07 -0400
Date: Tue, 26 Aug 2003 23:28:06 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-ID: <20030827032806.GA17938@kurtwerks.com>
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es> <20030825222215.GX7038@fs.tum.de> <1061857293.15168.3.camel@debian> <20030826234901.1726adec.aradorlinux@yahoo.es> <20030826215544.GI7038@fs.tum.de> <3F4C0FA0.1080201@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4C0FA0.1080201@comcast.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth David van Hoose:

[ALSA versus OSS in 2.4]

> Last time I checked i810 audio did NOT work under 2.4. That is why I 
> switched to ALSA. (The intel8x0 driver is perfectly stable for me)
> IMO, OSS should be phased out quickly as it is wasting energy to 
> maintain it. Those maintainers could be fixing the broken ALSA drivers 
> instead of wasting their time trying to fix the broken OSS drivers.
> ALSA should be included in 2.4 to help make the 2.4 to 2.6 hop easier.
> Thoughts about this?

ALSA is coming in 2.6 and installs easily enough on 2.4. In view of this,
MHO is that the upheaval for 2.4 users is not worth the tradeoff for what
looks like minimal gain. 2.4 is stable, modulo bug fixes and major brain
farts. If anything, I'd rather see XFS integrated into 2.4 than ALSA.

My 2*10^^-2 dollars.

Kurt
-- 
Anything is good if it's made of chocolate.
