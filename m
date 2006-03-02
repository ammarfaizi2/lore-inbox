Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWCBQiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWCBQiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWCBQiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:38:00 -0500
Received: from mail.dvmed.net ([216.237.124.58]:57024 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751078AbWCBQh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:37:59 -0500
Message-ID: <44071F5A.6050104@pobox.com>
Date: Thu, 02 Mar 2006 11:37:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
CC: Jens Axboe <axboe@suse.de>, "Eric D. Mudama" <edmudama@gmail.com>,
       Tejun Heo <htejun@gmail.com>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <carlos.pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	    <4405F471.8000602@rtr.ca>	    <1141254762.11543.10.camel@rousalka.dyndns.org>    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com> <65320.192.54.193.25.1141315183.squirrel@rousalka.dyndns.org>
In-Reply-To: <65320.192.54.193.25.1141315183.squirrel@rousalka.dyndns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
> The controller in the bugzilla entry ie a SiI 3114.
> It was a quick fix and I did expect more thorough investigation later
> (probably 2.6.17 frame). Though it seems FUA-related problems are so
> numerous FUA itself will be blacklisted for 2.6.16, so the limited
> blacklist is no longer needed.

Well, we're looking for a long term solution :)

Disabling FUA by default in 2.6.16 is a temporary solution.

	Jeff


