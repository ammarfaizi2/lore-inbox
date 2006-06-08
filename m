Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWFHCJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWFHCJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFHCJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:09:23 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:52814 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932460AbWFHCJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:09:23 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20060607211455.GA6132@elte.hu>
References: <20060607211455.GA6132@elte.hu>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 19:09:20 -0700
Message-Id: <1149732560.7316.2.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change was the port to 2.6.17-rc6, and the moving to John's 
> latest and greatest GTOD queue. Most of the porting was done by Thomas 
> Gleixner (thanks Thomas!). We also picked up the freshest genirq queue 
> from -mm and the freshest PI-futex patchset. There are also lots of ARM 
> fixups and enhancements from Deepak Saxena and Daniel Walker.
> 

Does this release also include the lastest hrtimers code ?

Daniel

