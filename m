Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbULOQja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbULOQja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbULOQj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:39:29 -0500
Received: from mail4.utc.com ([192.249.46.193]:40323 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262387AbULOQjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:39:11 -0500
Message-ID: <41C0689E.7080907@cybsft.com>
Date: Wed, 15 Dec 2004 10:38:54 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
References: <20041124101626.GA31788@elte.hu> <200412142138.10456.gene.heskett@verizon.net> <41C05733.8050100@cybsft.com> <200412151134.17738.gene.heskett@verizon.net>
In-Reply-To: <200412151134.17738.gene.heskett@verizon.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Wednesday 15 December 2004 10:24, K.R. Foley wrote:
> 
>>Gene Heskett wrote:
>>
>>>Did you see my comment about the later versions seeming to slow
>>>seti a wee bit?  Other than that, I'm in love with this, the
>>>whole system just plain feels better.  The only thing on my wish
>>>list right now is to be able to shut tvtime up, it grows the
>>>system log about a megabyte a minute with its missed read reports.
>>>Or is it tvtime that needs help?
>>
>>Are you referring to the "Read missed before next interrupt"
>>messages? If so, you can disable this by disabling the rtc
>>histogram under: Device Drivers --> Character devices --> Real Time
>>Clock Histogram Support.
> 
> 
> Ok, thats building now.  Silly Q:  Can that be turned back on with a
> setting in /proc or /sys?
> 

Not currently.

kr
