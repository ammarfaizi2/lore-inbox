Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752183AbWCPAOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbWCPAOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWCPAOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:14:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:1167 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932620AbWCPAOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:14:24 -0500
Message-ID: <4418ADD0.3050808@garzik.org>
Date: Wed, 15 Mar 2006 19:14:08 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com>	 <4408BEB5.7000407@garzik.org>	 <20060303234330.GA14401@ti64.telemetry-investments.com>	 <200603040107.27639.ak@suse.de>	 <20060315213638.GA17817@ti64.telemetry-investments.com>	 <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu>	 <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu>	 <44189A3D.5090202@garzik.org> <1142467290.1671.107.camel@mindpipe>
In-Reply-To: <1142467290.1671.107.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> 
>>Alas, it is far from that simple :(
>>
>>The code I linked to isn't in a working state.  NV contributed it 
>>largely as "it worked at one time" documentation of a 
>>previously-undocumented register interface.
>>
>>Someone needs to debug it.

> Would you expect every device supported by sata_nv to have this bug?

We don't know yet what "this bug" is.

	Jeff



