Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269874AbUH0AnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269874AbUH0AnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269856AbUH0AjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:39:03 -0400
Received: from [82.154.234.12] ([82.154.234.12]:51373 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S269854AbUH0Ahc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:37:32 -0400
Message-ID: <412E824F.90704@vgertech.com>
Date: Fri, 27 Aug 2004 01:37:35 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org> <52540000.1093553736@flay> <412E7004.3070503@kolivas.org>
In-Reply-To: <412E7004.3070503@kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Martin J. Bligh wrote:

[..]

>>
>> Yup. I can open a large 8Mpixel camera image in "display" and hang the 
>> whole
>> system for about 30s too ;-(
> 

Congrats! 8MP camera! :-)

> 
> If you're talking about using the embedded image viewer in kde, that 
> spins on wait and wastes truckloads of cpu (a perfect example of poor 
> coding). Try loading it an external viewer and it will be 1000 times 
> faster. If you're talking about it keeping the disk too busy on the 
> other hand, that's I/O scheduling.
> 

The question is: "can a poorly coded app hang the system for 30secs?"

That's a DoS ;-)

Regards,
Nuno Silva

