Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbVKPSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVKPSzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbVKPSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:55:15 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:45086 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1030384AbVKPSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:55:14 -0500
Date: Wed, 16 Nov 2005 10:55:13 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Andrey Volkov <avolkov@varma-el.com>, Jean Delvare <khali@linux-fr.org>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-ID: <20051116185513.GB18217@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116031520.GL5546@mag.az.mvista.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 08:15:20PM -0700, Mark A. Greer wrote:
> On Wed, Nov 16, 2005 at 12:48:59AM +0300, Andrey Volkov wrote:
> > > Mark, care to comment on that possibility, and/or on the code itself?
> > > 
> > And, please, remove unnecessary PPC dependence from Kconfig.
> 
> When I originally submitted the m41t00 patch, I made it clear that it
> was PPC only and gave the reason why:
> 
> http://archives.andrew.net.au/lm-sensors/msg29280.html

I have a MIPS platform with M41T81 (SiByte SWARM,
arch/mips/sibyte/swarm/rtc_m41t81.c) that I would dearly love to
decruftify.  (Don't pay too much attention to the kernel.org trees for
MIPS, you need to pull the git repo on linux-mips.org for the real
stuff.)

So I'm definitely interested in this work.

-andy
