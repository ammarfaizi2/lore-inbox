Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVHaRmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVHaRmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVHaRmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:42:38 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:16534 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964851AbVHaRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:42:37 -0400
Message-ID: <4315EC05.8060804@nortel.com>
Date: Wed, 31 Aug 2005 11:42:29 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
References: <1125354385.4598.79.camel@mindpipe> <43138F3B.7010704@nortel.com> <20050831173918.GA6713@in.ibm.com>
In-Reply-To: <20050831173918.GA6713@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2005 17:42:31.0236 (UTC) FILETIME=[5CCCA040:01C5AE53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Mon, Aug 29, 2005 at 10:43:45PM +0000, Christopher Friesen wrote:
>>Last time I got interested in this, the management of the event queues 
>>was still a fairly major performance hit.

> Hmm ..I dont see any event queues being managed by dyn-tick patch. 
> Are you referring to some old version which I havent seen perhaps?
> If so, what were those event queues used for?

Oh, sorry.  I think I got this confused with the tickless patch.

Chris
