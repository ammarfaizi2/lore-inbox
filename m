Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVEXCDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVEXCDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 22:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEXCDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 22:03:17 -0400
Received: from mail.timesys.com ([65.117.135.102]:23125 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261300AbVEXCDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 22:03:14 -0400
Message-ID: <42928AFF.7010503@timesys.com>
Date: Mon, 23 May 2005 22:01:35 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       sdietrich@mvista.com, john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
In-Reply-To: <1116890066.13086.61.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 May 2005 01:56:41.0000 (UTC) FILETIME=[D4209280:01C56003]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> I went to see Andrew Morton speak at Xerox PARC and he indicated that
> some of the RT patch was a little crazy . Specifically interrupts in
> threads (Correct me if I'm wrong Andrew). It seems a lot of the
> maintainers haven't really warmed up to it. 

Understandably at first encounter it may seem rather
unconventional.  However scheduled interrupt execution
has existed in Solaris for years.

What are the objections?

-john


-- 
john.cooper@timesys.com
