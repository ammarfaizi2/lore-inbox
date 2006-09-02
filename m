Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWIBBuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWIBBuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWIBBuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:50:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60328 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750811AbWIBBuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:50:16 -0400
Message-ID: <44F8E351.1010703@garzik.org>
Date: Fri, 01 Sep 2006 21:50:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: eholman@holtones.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>	 <20060827231421.f0fc9db1.akpm@osdl.org> <1157161201.3679.6.camel@parachute.holtones.com>
In-Reply-To: <1157161201.3679.6.camel@parachute.holtones.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elias Holman wrote:
>> From: Elias Holman <eholman@holtones.com>
>> Subject: PROBLEM: PCI/Intel 82945 trouble on Toshiba M400 notebook
> 
> I can successfully boot my M400 under 2.6.18-rc5.  Even better, I can
> now enable hotpluggable CPUs and successfully suspend and resume.  I
> needed the SATA patch (http://lkml.org/lkml/2006/7/20/56), referenced in
> the "T60 not coming out of suspend to RAM" thread as well, so I would
> like to second Michael Tsirkin's request that this be merged in.

As Andrew Morton noted, it's already queued for 2.6.19.

	Jeff




-- 
VGER BF report: H 0
