Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUDKQF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUDKQF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:05:56 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:5205 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262382AbUDKQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:05:55 -0400
Message-ID: <40796CDF.6020209@yahoo.com.au>
Date: Mon, 12 Apr 2004 02:05:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduler problems on shutdown
References: <1516092704.1081534916@[10.10.2.4]> <71390000.1081611090@[10.10.2.4]> <40791475.7040300@cyberone.com.au> <1860000.1081696302@[10.10.2.4]> <40796318.4010508@yahoo.com.au> <3400000.1081698143@[10.10.2.4]>
In-Reply-To: <3400000.1081698143@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>OK, I'll figure it out. I don't like the latest code, so don't really want
>>>to "upgrade" though.
>>
>>Oh? Anything specific?
> 
> 
> balance_on_clone, mostly.
> 

Oh, that is removed until more testing/tuning is done.

So far I haven't seen a benchmark with more than a few %
improvement. I thought I was going to be flooded with them
from the HPC guys after the last thread on the subject...
