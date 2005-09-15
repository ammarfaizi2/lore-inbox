Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbVIOPYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVIOPYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVIOPYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:24:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60586 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030258AbVIOPYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:24:53 -0400
Date: Thu, 15 Sep 2005 08:24:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MM] rapidio: message interface updates
Message-ID: <20050915082451.A26921@cox.net>
References: <20050907081312.B1925@cox.net> <5322C997-A1FD-47BB-B92B-17CBA627EC53@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5322C997-A1FD-47BB-B92B-17CBA627EC53@freescale.com>; from kumar.gala@freescale.com on Thu, Sep 15, 2005 at 10:05:43AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 10:05:43AM -0500, Kumar Gala wrote:
> I'm guessing we are looking at a 2.6.15 timeframe now for getting the  
> RapidIO subsystem in?  Are there any other changes beyond what is  
> setting in -mm that need to be done?

Well, at least 2.6.15, 2.6.14 cutoff has passed. We are waiting on
a review of of the rionet updates I reposted a week ago. I've held
off on going too far with MMIO and 8548 support since the last rionet
changes required changes to the messaging support.

-Matt
