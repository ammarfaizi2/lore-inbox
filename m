Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUF3TOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUF3TOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUF3TOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:14:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57843 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261159AbUF3TOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:14:06 -0400
Message-ID: <40E310C6.5020105@mvista.com>
Date: Wed, 30 Jun 2004 12:13:10 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: boris.hu@intel.com, drepper@redhat.com, adam.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bugfix for CLOCK_REALTIME absolute timer.
References: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>	<40E0F48F.4030205@mvista.com> <20040628215748.4ea128bc.akpm@osdl.org>
In-Reply-To: <20040628215748.4ea128bc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
~

> I fixed that up - please test next -mm, check that it all works?

It passes all my tests.  Boris gives a thumbs up also.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

