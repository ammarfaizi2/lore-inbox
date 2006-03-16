Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWCPABe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWCPABe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWCPABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:01:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48353 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932611AbWCPABd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:01:33 -0500
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
	ticks on PM timer]
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
In-Reply-To: <44189A3D.5090202@garzik.org>
References: <200602280022.40769.darkray@ic3man.com>
	 <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
	 <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu>
	 <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu>
	 <44189A3D.5090202@garzik.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 19:01:30 -0500
Message-Id: <1142467290.1671.107.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 17:50 -0500, Jeff Garzik wrote:
> Alas, it is far from that simple :(
> 
> The code I linked to isn't in a working state.  NV contributed it 
> largely as "it worked at one time" documentation of a 
> previously-undocumented register interface.
> 
> Someone needs to debug it.

Would you expect every device supported by sata_nv to have this bug?

Lee

