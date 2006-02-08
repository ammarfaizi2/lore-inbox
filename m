Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWBHD3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWBHD3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWBHD3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:29:01 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:58977 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030488AbWBHD27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:28:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=K7TTXJ8OMCwJ1xZ9urXcRaTFx0cyeCtSeam83UZe1V9FWRpxgdZoVGwYiugvXhU1MNPHPSsgNijAb/57u3zo2BCL/nk6i5IbK2KwGHMm828bkn+S5hWGy5pmCtlFvAiT3L9dpRdvP6f/84QmSJ6YQ5npKX7KQr8mP5Pcmo1uviE=  ;
Message-ID: <43E96577.1080208@yahoo.com.au>
Date: Wed, 08 Feb 2006 14:28:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, npiggin@suse.de, mingo@elte.hu,
       rostedt@goodmis.org, pwil3058@bigpond.net.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org>	<20060207141525.19d2b1be.akpm@osdl.org>	<200602081011.09749.kernel@kolivas.org> <20060207153617.6520f126.akpm@osdl.org>
In-Reply-To: <20060207153617.6520f126.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> In that case I think we're better off fixing both problems rather than
> fixing neither.
> 
> Suresh, Martin, Ingo, Nick and Con: please drop everything, triple-check
> and test this:
> 

OK, great. I was under the impression that this still had problems
but Peter and Martin seem to agree they've been resolved.

> 
> 
> From: Peter Williams <pwil3058@bigpond.net.au>
> 

...

I'll give it some testing.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
