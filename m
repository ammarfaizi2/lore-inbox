Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVC3ImO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVC3ImO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVC3ImO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:42:14 -0500
Received: from waste.org ([216.27.176.166]:51155 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261542AbVC3ImL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:42:11 -0500
Date: Wed, 30 Mar 2005 00:42:09 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christensen Tom <paveraware@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network Performance Ingo's RT-Preempt
Message-ID: <20050330084209.GF25554@waste.org>
References: <BAY104-F21CE6F100043D58186803FDF430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY104-F21CE6F100043D58186803FDF430@phx.gbl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 10:27:40PM +0000, Christensen Tom wrote:
> I'm running 2.6.11 with Ingo's Preempt patch 
> (realtime-preempt-2.6.11-final-V0.7.40-04).  The system is SMP with a 
> broadcom NIC (tg3 driver).  I am seeing truly appalling network performance 
> (2-4kbps on a 1gbps network).  Is this a known issue?  I know this patch is 
> not production ready, what traces/logs do you need/want to be able to 
> debug/fix this?

What is your test app and what protocol does it use?

What performance do you get with mainline?

A tcpdump log is probably a good place to start. You might consider
cc:ing Ingo and possibly netdev.

-- 
Mathematics is the supreme nostalgia of our time.
