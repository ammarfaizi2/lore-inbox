Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423072AbWJGDKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423072AbWJGDKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 23:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423074AbWJGDKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 23:10:07 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:24661 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1423072AbWJGDKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 23:10:05 -0400
Subject: Re: [PATCH 00/10] -mm: generic clocksource API -v2
From: Daniel Walker <dwalker@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061006185328.6b57fa83.akpm@osdl.org>
References: <20061006185439.667702000@mvista.com>
	 <20061006185328.6b57fa83.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 20:10:03 -0700
Message-Id: <1160190603.6378.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:53 -0700, Andrew Morton wrote:
> 
> Well it all applies on top of the hrtimer/dynticks stuff with only a bit of
> fixing needed.  And then it compiles.

That makes sense, they should be pretty discrete.

> But there's been so much time-related work happening lately that I'm
> inclined to park this work for a while, give the existing changes time to
> settle in and get debugged.  And to give people time to review this new
> material.  If that review is positive, we can bring this material into
> -mm in a week or so.  OK?

Yeah, I'm not in a rush. Whatever you think is best.

Daniel

