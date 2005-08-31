Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVHaRjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVHaRjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVHaRjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:39:53 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40328 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964905AbVHaRjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:39:52 -0400
Date: Wed, 31 Aug 2005 23:09:18 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050831173918.GA6713@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1125354385.4598.79.camel@mindpipe> <43138F3B.7010704@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43138F3B.7010704@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 10:43:45PM +0000, Christopher Friesen wrote:
> Last time I got interested in this, the management of the event queues 
> was still a fairly major performance hit.
> 
> Has this overhead been brought down to reasonable levels?

Hmm ..I dont see any event queues being managed by dyn-tick patch. 
Are you referring to some old version which I havent seen perhaps?
If so, what were those event queues used for?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
