Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVC3I6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVC3I6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVC3I6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:58:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58069 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261549AbVC3I6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:58:09 -0500
Subject: Re: Network Performance Ingo's RT-Preempt
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Christensen Tom <paveraware@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050330084209.GF25554@waste.org>
References: <BAY104-F21CE6F100043D58186803FDF430@phx.gbl>
	 <20050330084209.GF25554@waste.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 03:58:07 -0500
Message-Id: <1112173087.5598.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 00:42 -0800, Matt Mackall wrote:
> On Sun, Mar 27, 2005 at 10:27:40PM +0000, Christensen Tom wrote:
> > I'm running 2.6.11 with Ingo's Preempt patch 
> > (realtime-preempt-2.6.11-final-V0.7.40-04).  The system is SMP with a 
> > broadcom NIC (tg3 driver).  I am seeing truly appalling network performance 
> > (2-4kbps on a 1gbps network).  Is this a known issue?  I know this patch is 
> > not production ready, what traces/logs do you need/want to be able to 
> > debug/fix this?
> 
> What is your test app and what protocol does it use?
> 
> What performance do you get with mainline?
> 
> A tcpdump log is probably a good place to start. You might consider
> cc:ing Ingo and possibly netdev.
> 

Before you even bother, try the latest version.  That version is too old
to be useful for debugging.

Lee

