Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbULRM0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbULRM0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 07:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbULRM0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 07:26:01 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:50437 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S262869AbULRMZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 07:25:50 -0500
Message-ID: <41C420C1.6070504@globaledgesoft.com>
Date: Sat, 18 Dec 2004 17:51:21 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: drizzd@aon.at
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Documentation on top half and bottom halves
References: <41C3F9A2.3040700@globaledgesoft.com>
In-Reply-To: <41C3F9A2.3040700@globaledgesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much

On Sat, Dec 18, 2004 at 03:04:26PM +0530, krishna wrote:
>    Can any one tell me good Documentation on bottom halves beyond doubt.

Documentation on Tasklets:

- http://www.xml.com/ldd/chapter/book/ch09.html#t5
- kernel/softirq.c

Documentation on Workqueues:

- http://lwn.net/Articles/23634/
- kernel/workqueue.c


Clemens
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


