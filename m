Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbULNWqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbULNWqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:42:31 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:48297 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261694AbULNWkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:40:45 -0500
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <1103063312.14699.54.camel@krustophenia.net>
Message-ID: <cone.1103064011.405603.25531.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrea Arcangeli <andrea@suse.de>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Date: Wed, 15 Dec 2004 09:40:11 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell writes:

> On Mon, 2004-12-13 at 10:36 +1100, Con Kolivas wrote:
>> The performance benefit, if any, is often lost in noise during 
>> benchmarks and when there, is less than 1%.
> 
> I have measured 2.1-2.3% residency for the timer ISR on my 600Mhz VIA
> C3.  And this is a desktop - you have many many embedded systems that
> are slower.  For these systems the difference is very real.

Could you explain residency and it's relevance to throughput please? I've 
not heard this term before.

Cheers,
Con

