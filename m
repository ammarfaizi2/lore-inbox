Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVJ1Xyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVJ1Xyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVJ1Xyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:54:37 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53632 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750755AbVJ1Xyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:54:36 -0400
Message-ID: <4362BA30.2020504@pobox.com>
Date: Fri, 28 Oct 2005 19:54:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: kernel performance update - 2.6.14
References: <200510282344.j9SNihg27345@unix-os.sc.intel.com>
In-Reply-To: <200510282344.j9SNihg27345@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Kernel performance data for 2.6.14 (released yesterday) is updated at:
> http://kernel-perf.sourceforge.net
> 
> As expected, results are within run variation compares to 2.6.14-rc5.
> No significant deviation found compare to 2.6.14-rc5

Do I read this correctly:  according to your benchmarks, fileio-noop and 
fileio-cfq are down some 20% or more, across all machine configurations, 
since 2.6.9? In the 4P configuration, dbench-{noop,as} both seem to have 
regressed as well.

	Jeff


