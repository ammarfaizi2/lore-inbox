Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWAMQQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWAMQQW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWAMQQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:16:22 -0500
Received: from smtp-out.google.com ([216.239.45.12]:9717 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964856AbWAMQQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:16:21 -0500
Message-ID: <43C7D22E.70401@google.com>
Date: Fri, 13 Jan 2006 08:15:42 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au>
In-Reply-To: <43C75178.80809@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Attached is a new patch to fix the excessive idle problem.  This patch 
> takes a new approach to the problem as it was becoming obvious that 
> trying to alter the load balancing code to cope with biased load was 
> harder than it seemed.
>

OK, well the last one didn't work.
(peterw-fix-excessive-idling-with-smp-move-load-not-tasks)

If Andy is feeling very kind, perhaps he will kick this one too.
This one is for real, right? ;-)

M.

