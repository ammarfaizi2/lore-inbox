Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWHPTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWHPTXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHPTXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:23:05 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:14313
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750997AbWHPTXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:23:04 -0400
Message-ID: <44E37095.9070200@microgate.com>
Date: Wed, 16 Aug 2006 14:23:01 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe>
In-Reply-To: <1155753868.3397.41.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-08-16 at 12:45 +0200, Raphael Hertzog wrote:
>>Now I switched to stock 2.6 and while the stock kernel improved in
>>responsiveness, it still isn't enough by default (even with
>>CONFIG_PREEMPT=y and CONFIG_HZ=1000). So I wanted to try the "rt" patch of
>>Ingo Molnar and Thomas Gleixner, but the patched kernel doesn't boot (see
>>bug report in a separate mail on this list).
> 
> 
> Does the serial performance seem to have regressed from 2.4 to 2.6?  I
> am chasing a similar issue with a serial MIDI card (supported by the bog
> standard 8250 serial driver) that drops notes under 2.6 but works with
> 2.4.  I don't have details yet, but it sounds like a similar problem.

What specific 2.6 kernels are each of you using?

-- 
Paul Fulghum
Microgate Systems, Ltd.
