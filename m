Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVCYTNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVCYTNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVCYTNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:13:44 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:5807 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261747AbVCYTNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:13:42 -0500
Date: Fri, 25 Mar 2005 14:13:43 -0500 (EST)
From: Ricardo Colon <rcolon@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: megaraid driver (proposed patch)
In-Reply-To: <20050325190732.GA15497@infradead.org>
Message-ID: <Pine.GSO.4.60-041.0503251412070.1327@unix5.andrew.cmu.edu>
References: <20050325182252.GA4268@morley.grenoble.hp.com>
 <1111775992.5692.25.camel@mulgrave> <20050325184718.GA15215@infradead.org>
 <1111777477.5692.29.camel@mulgrave> <20050325190732.GA15497@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please remove me from these mailing lists?

I don't remember signing up ffor them and it's filling
my inbox too quickly.

On Fri, 25 Mar 2005, Christoph Hellwig wrote:

> On Fri, Mar 25, 2005 at 01:04:37PM -0600, James Bottomley wrote:
>> You get a kernel with two drivers trying to claim some of the same set
>> of cards.  The winner will be the driver that gets its init routines
>> called first, but this isn't a desirable outcome.
>>
>> I wouldn't object to a patch that allows both *modules* to be built,
>> which is all I think the distros are after.
>
> The new megaraid driver doesn't support old hardware.  Maybe we should
> drop the overlapping pci ids from the old driver?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
