Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWHYTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWHYTfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbWHYTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:35:45 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:43461 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1422814AbWHYTfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:35:45 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, nickpiggin@yahoo.com.au
In-Reply-To: <44EF4EED.2040904@linux.intel.com>
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
	 <1156520608.10471.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	 <44EF4EED.2040904@linux.intel.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 12:35:42 -0700
Message-Id: <1156534542.10471.13.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 21:26 +0200, Arjan van de Ven wrote:
> > 
> > The name space here is bugging me a little. Maybe prefix them with
> > "pm_latency" so you'd have "pm_latency_set_acceptable()" ,
> > "pm_latency_modify_acceptable()" , something like that. Likewise with
> > the file names , "include/linux/pm_latency.h"
> > 
> 
> there is no reason why this should JUST be about power management....

I'm just suggesting it would be nice to have a clear prefix on each
function. It's up to you what that prefix is.

Daniel

