Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWCCDUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWCCDUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 22:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCCDUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 22:20:21 -0500
Received: from colin.muc.de ([193.149.48.1]:23048 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751686AbWCCDUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 22:20:20 -0500
Date: 3 Mar 2006 04:20:15 +0100
Date: Fri, 3 Mar 2006 04:20:15 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Message-ID: <20060303032015.GA12517@muc.de>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com> <20060303.114406.64806237.nemoto@toshiba-tops.co.jp> <20060302190408.1e754f12.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302190408.1e754f12.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi, have you had time to think about it all?

No, sorry.

-Andi
