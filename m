Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTBUJH4>; Fri, 21 Feb 2003 04:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBUJH4>; Fri, 21 Feb 2003 04:07:56 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:43767 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267260AbTBUJHz>;
	Fri, 21 Feb 2003 04:07:55 -0500
Message-ID: <3E55EEA7.6060401@mvista.com>
Date: Fri, 21 Feb 2003 01:17:27 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: anton@samba.org, davem@redhat.com, torvalds@transmeta.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: POSIX clocks and timers tests update
References: <20030218205839.30551ba6.akpm@digeo.com>	<20030220054925.GA8748@krispykreme>	<20030219215916.3dfc76b3.akpm@digeo.com>	<3E54925E.7030109@mvista.com> <20030220003902.6156d00e.akpm@digeo.com>
In-Reply-To: <20030220003902.6156d00e.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The POSIX clocks and timers support package on sourceforge has been 
updated.  It now _should_ work with all platforms.  I am sure you will 
tell me if it doesn't :)

This should make it easy to test new archs as they connect the POSIX 
clocks and timers system calls.

I have also included a new timer stress test from Randy Dunlap.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

