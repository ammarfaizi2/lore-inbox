Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266306AbUFPNEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUFPNEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266301AbUFPNEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:04:24 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:47028 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266287AbUFPNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:02:02 -0400
Message-ID: <40D044BA.4080009@kolivas.org>
Date: Wed, 16 Jun 2004 23:01:46 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7a (X11/20040614)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
References: <1087333441.40cf6441277b5@vds.kolivas.org> <40D04439.5080100@gmx.de>
In-Reply-To: <40D04439.5080100@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Con Kolivas wrote:
> 
>> Here is an updated version of the staircase scheduler. I've been 
>> trying to hold
>> off for 2.6.7 final but this has not been announced yet. Here is a 
>> brief update
>> summary.
> 
> 
> Hi, does this resolve the issue with ut2004? (Or is another setting for 
> it needed?) I haven't tried myself, but others reported that setting 
> interactive to 0 didn't help, nor giving ut2004 more priority via (re)nice.

Good question. I don't own UT2004 so I was hoping a tester might 
enlighten me.

Con
