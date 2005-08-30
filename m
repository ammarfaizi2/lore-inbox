Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVH3AGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVH3AGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 20:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVH3AGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 20:06:03 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:2750 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932090AbVH3AGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 20:06:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Christopher Friesen" <cfriesen@nortel.com>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Date: Tue, 30 Aug 2005 10:05:06 +1000
User-Agent: KMail/1.8.2
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
References: <1125354385.4598.79.camel@mindpipe> <43138F3B.7010704@nortel.com>
In-Reply-To: <43138F3B.7010704@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301005.07353.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005 08:42, Christopher Friesen wrote:
> Lee Revell wrote:
> > The controversy over the introduction of CONFIG_HZ demonstrated the
> > urgency of getting a dynamic tick solution merged before 2.6.14.
> >
> > Anyone care to give a status report?  Con, do you feel that the last
> > version you posted is ready to go in?
>
> Last time I got interested in this, the management of the event queues
> was still a fairly major performance hit.
>
> Has this overhead been brought down to reasonable levels?

Srivatsa is still working on the smp-aware scalable version, so it's back in 
the development phase.

Cheers,
Con
