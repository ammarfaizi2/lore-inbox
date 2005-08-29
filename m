Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVH2WmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVH2WmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVH2WmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:42:14 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:30615 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751398AbVH2WmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:42:14 -0400
Message-ID: <43138F3B.7010704@nortel.com>
Date: Mon, 29 Aug 2005 16:42:03 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
References: <1125354385.4598.79.camel@mindpipe>
In-Reply-To: <1125354385.4598.79.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2005 22:42:05.0145 (UTC) FILETIME=[E141FC90:01C5ACEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> The controversy over the introduction of CONFIG_HZ demonstrated the
> urgency of getting a dynamic tick solution merged before 2.6.14.
> 
> Anyone care to give a status report?  Con, do you feel that the last
> version you posted is ready to go in?

Last time I got interested in this, the management of the event queues 
was still a fairly major performance hit.

Has this overhead been brought down to reasonable levels?

Chris
