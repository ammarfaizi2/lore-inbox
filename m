Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWBFHAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWBFHAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWBFHAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:00:21 -0500
Received: from c-71-193-195-148.hsd1.or.comcast.net ([71.193.195.148]:23177
	"EHLO vkl.ath.cx") by vger.kernel.org with ESMTP id S1751046AbWBFHAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:00:20 -0500
Date: Sun, 5 Feb 2006 23:00:12 -0800 (PST)
From: Dan McDonald <dan@vkl.ath.cx>
X-X-Sender: dan@dan
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx devices]
In-Reply-To: <1139202455.3131.56.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0602052255110.10566@dan>
References: <1139154997.14624.20.camel@localhost.localdomain> 
 <20060205192025.4006a554.akpm@osdl.org> <1139202455.3131.56.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Feb 2006, Arjan van de Ven wrote:

> On Sun, 2006-02-05 at 19:20 -0800, Andrew Morton wrote:
>> Richard Purdie <rpurdie@rpsys.net> wrote:
>>>
>>> +MODULE_AUTHOR("John Bowler <jbowler@acm.org>");
>>> +MODULE_DESCRIPTION("IXP4XX GPIO LED driver");
>>> +MODULE_LICENSE("MIT");
>>
>> MIT license is unusual.  There's one other file in the kernel which uses it
>> and that's down in MTD where nobody dares look.
>>
>> I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.
>
> would be really nice if the author would at least dual license it under
> the GPL as well (and thus also granting the patent rights if any)

It would be really nice, but that doesn't make the rights to any patents 
granted unless 'GPLv2 or any later version' is explicitly specified. The 
default GPL license is v2 and only v2. There was a bug thread about this 
on LKML earlier.


Dan
