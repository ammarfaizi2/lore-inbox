Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWB0Uzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWB0Uzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWB0Uzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:55:48 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:15684 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751121AbWB0Uzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:55:48 -0500
Date: Mon, 27 Feb 2006 15:55:26 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Lse-tech] [Patch 2/7] Add sysctl for schedstats
In-reply-to: <1141059917.23775.41.camel@serpentine.pathscale.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Message-id: <4403673E.3020208@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141027367.5785.42.camel@elinux04.optonline.net>
 <1141027923.5785.50.camel@elinux04.optonline.net>
 <1141059917.23775.41.camel@serpentine.pathscale.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:

>On Mon, 2006-02-27 at 03:12 -0500, Shailabh Nagar wrote:
>
>  
>
>>Add sysctl option for controlling schedstats collection
>>dynamically. Delay accounting leverages schedstats for
>>cpu delay statistics.
>>    
>>
>
>Is there some reason you're using the sysctl interface, and not say
>sysfs instead?
>
>	<b
>
No. Is /proc/sys/kernel deprecated in favor of /sys/kernel now ?

--Shailabh


