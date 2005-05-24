Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVEXJnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEXJnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVEXJmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:42:25 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:26056 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261976AbVEXJVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:21:22 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092118.4F404FA75@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:21:18 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 399D6FB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:40 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261300AbVEXCDR (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 22:03:17 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEXCDR

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 22:03:17 -0400

Received: from mail.timesys.com ([65.117.135.102]:23125 "EHLO

	exchange.timesys.com") by vger.kernel.org with ESMTP

	id S261300AbVEXCDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 22:03:14 -0400

Received: from [127.0.0.1] ([192.168.2.230]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);

	 Mon, 23 May 2005 21:56:39 -0400

Message-ID: <42928AFF.7010503@timesys.com>

Date:	Mon, 23 May 2005 22:01:35 -0400

From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)

X-Accept-Language: en-us, en

MIME-Version: 1.0

To: dwalker@mvista.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
	sdietrich@mvista.com, john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance

References: <1116890066.13086.61.camel@dhcp153.mvista.com>

In-Reply-To: <1116890066.13086.61.camel@dhcp153.mvista.com>

Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Content-Transfer-Encoding: 7bit

X-OriginalArrivalTime: 24 May 2005 01:56:41.0000 (UTC) FILETIME=[D4209280:01C56003]

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

