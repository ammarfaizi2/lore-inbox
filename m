Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWHKVKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWHKVKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWHKVJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:09:59 -0400
Received: from rtr.ca ([64.26.128.89]:10732 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932277AbWHKVJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:09:59 -0400
Message-ID: <44DCF222.60309@rtr.ca>
Date: Fri, 11 Aug 2006 17:09:54 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com>
In-Reply-To: <20060811210104.GL26930@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>
> A userspace governor can pretty much invent its own rules. I'm not
> familiar with what constraints powernowd has.  It may even have
> limits defined in a config file someplace.
> 
> Is it behaving again with ondemand ?

So far, so good, thanks.

I seem to recall having killed off powernowd when I first installed
the system here, but perhaps a subsequent update reenabled it again.

Bah!

Cheers
