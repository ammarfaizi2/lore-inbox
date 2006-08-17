Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWHQX3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWHQX3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWHQX3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:29:34 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:10959 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1030370AbWHQX3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:29:33 -0400
Message-ID: <44E4FBC8.1040607@mauve.plus.com>
Date: Fri, 18 Aug 2006 00:29:12 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
References: <20060815175525.A2333@unix-os.sc.intel.com>	<20060815212455.c9fe1e34.pj@sgi.com>	<20060815214718.00814767.akpm@osdl.org>	<20060816110357.B7305@unix-os.sc.intel.com>	<20060817102030.f8c41330.pj@sgi.com>	<20060817110317.A14787@unix-os.sc.intel.com> <20060817121804.e140f19e.pj@sgi.com>
In-Reply-To: <20060817121804.e140f19e.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Suresh wrote:
>> Let me resist the temptation and not go into the definition of horsepower
>> here. You can refer any dictionary.
> 
> Good point <grin>.
> 
> Horsepower is a measure of power, of energy over time, such as the
> rate of providing or using electrical or mechanical energy.
> 
> So, with your suggestion of 'horsepower', are you saying that cpu_power
> is a metric of such electrical or mechanical energy -- the peak or
> average watts of the electricity consumed by the CPUs in a group?

And is white_power, the energy output of a redneck on a step machine?

Power has assorted meanings over and above the J/s one.

I'd suggest 'computing_power' might be less ambiguous.
