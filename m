Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVFIXze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVFIXze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFIXzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:55:33 -0400
Received: from mail.timesys.com ([65.117.135.102]:41639 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262210AbVFIXyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:54:04 -0400
Message-ID: <42A8D630.3030008@timesys.com>
Date: Thu, 09 Jun 2005 19:52:16 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>	 <1117312557.10746.6.camel@lade.trondhjem.org>	 <4299332F.6090900@timesys.com>	 <1117352410.10788.29.camel@lade.trondhjem.org>	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>	 <429DF8DE.7060008@timesys.com>	 <1117650718.10733.65.camel@lade.trondhjem.org>	 <429E0A86.7000507@timesys.com>	 <1117657267.10733.106.camel@lade.trondhjem.org>	 <429E21B8.2070404@timesys.com>	 <1117666319.10822.17.camel@lade.trondhjem.org>	 <429E7D91.9000808@timesys.com> <1117686367.10822.104.camel@lade.trondhjem.org> <42A8CE19.1000807@mvista.com>
In-Reply-To: <42A8CE19.1000807@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2005 23:46:53.0843 (UTC) FILETIME=[83A47630:01C56D4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Excuse me for interrupting this thread, but have you seen:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111717961227508&w=2
> 
> I think this will fix your problem.

That was touched on earlier in the thread.  It did not
fix the problem I was chasing in 40-04.

I'll revisit this issue once I've moved to a more current
version of the patch should it still exist.

-john


-- 
john.cooper@timesys.com
