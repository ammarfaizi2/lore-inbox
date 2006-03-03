Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWCCWKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWCCWKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWCCWKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:10:18 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750815AbWCCWKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:10:16 -0500
Message-ID: <4408BEB5.7000407@garzik.org>
Date: Fri, 03 Mar 2006 17:09:57 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: AMD64 X2 lost ticks on PM timer
References: <200602280022.40769.darkray@ic3man.com>	 <200603011647.34516.ak@suse.de>	 <20060301180714.GD20092@ti64.telemetry-investments.com>	 <200603011929.59307.ak@suse.de> <1141240611.5860.176.camel@mindpipe>	 <20060303191822.GE32407@ti64.telemetry-investments.com> <1141421204.3042.139.camel@mindpipe>
In-Reply-To: <1141421204.3042.139.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> All this tells me is that your system's timer is screwed up (not news).

Or sata_nv/libata is to blame.

	Jeff



