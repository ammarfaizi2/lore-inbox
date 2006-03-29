Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWC3U1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWC3U1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWC3U1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:27:46 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:59927 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750854AbWC3U1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:27:45 -0500
Message-ID: <442AE55B.5020007@tmr.com>
Date: Wed, 29 Mar 2006 14:51:55 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Mattia Dongili <malattia@linux.it>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
References: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com> <442219A4.3080801@garzik.org>
In-Reply-To: <442219A4.3080801@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pallipadi, Venkatesh wrote:
>>> From cpufreq perspective multiple things are possible in the way
>> processor will support the multi-core frequency changing. and most of
>> the things are handled at cpufreq inside kernel. I think there should be
>> minima changes required in cpufreqd if any.
>> Options:
> 
> 
> 4) we power down a core.
> 
Is this just for completeness of the set, something someone might do 
someday, or does someone really have a hotplug core product?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

