Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVINQVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVINQVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVINQVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:21:55 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43012 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030238AbVINQVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:21:54 -0400
Message-ID: <43284B61.50509@tmr.com>
Date: Wed, 14 Sep 2005 12:10:09 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chriswhite@gentoo.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Quick update on latest Linux kernel performance
References: <200509132132.j8DLWJg04553@unix-os.sc.intel.com> <200509141517.38985.chriswhite@gentoo.org>
In-Reply-To: <200509141517.38985.chriswhite@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris White wrote:
> On Wednesday 14 September 2005 06:32, Chen, Kenneth W wrote:
> 
>>New performance result are posted on http://kernel-perf.sourceforge.net
>>with latest data collected on kernel 2.6.13-git9.
> 
> 
> [snip]
> 
> 
>>Take a look at the performance data.  Comments and suggestions are always
>>welcome and please post them to LKML.
> 
> 
> The benchmarks here have a slight flaw in that the main hardware components 
> tested are not given.  About the only thing I can see regarding these tests 
> is what processor they run on.  Displaying network performance tests without 
> showing the network card or io tests without showing the disk controller 
> seems rather odd.  I guess it comes down to requesting a full hardware 
> rundown.  If this is displayed someplace on the site or elsewhere please 
> provide the link.

Unless the hardware was changed, this is not particularly relevant. It's 
good testing to change only one thing, so you know that's what caused 
the change in results.

I think the config was posted at least once, you can probably find it in 
the archives if not on the site.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

