Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752065AbWAEGkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbWAEGkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWAEGkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:40:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:15558 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752065AbWAEGks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:40:48 -0500
Subject: Re: [2.6 patch] the scheduled removal of obsolete OSS drivers
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601031344480.32658@yvahk01.tjqt.qr>
References: <20060103114900.GA3831@stusta.de>
	 <6bffcb0e0601030401n97997a0n@mail.gmail.com>
	 <Pine.LNX.4.61.0601031344480.32658@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 01:40:45 -0500
Message-Id: <1136443246.24475.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 13:46 +0100, Jan Engelhardt wrote:
> >[snip]
> >>  124 files changed, 11 insertions(+), 90412 deletions(-)
> >                                                        ^^^^^^^
> >                                                        Cool :)
> 
> Since when is "-)" cool?
> 
> 
> >PS. Greg's remove-devfs patch is also cool :).
> 
> Oh yeah. When 2.6.0 got out, the kernel tree was 32475 KB. By 2.6.15, it is 
> already 38899 KB. Time to get some dust off :D

Why is this a problem?  The 2.6.15 kernel is capable of a lot more than
2.6.0.  Of course it's bigger.  Unless you have some magic toolchain
that can add features without adding any code.

Lee

