Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVAMAGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVAMAGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVAMAGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:06:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46243 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261597AbVALXzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:55:31 -0500
Message-ID: <41E5B8B6.8050204@pobox.com>
Date: Wed, 12 Jan 2005 18:54:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK] TUN/TAP driver update and fixes for 2.6.BK
References: <41E5A5DA.1010301@qualcomm.com> <41E5B077.8030300@pobox.com> <41E5B7DC.8020301@qualcomm.com>
In-Reply-To: <41E5B7DC.8020301@qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Krasnyansky wrote:
> Jeff Garzik wrote:
> 
>> Non-technical comments:
>>
>> 1) Please send drivers/net patches to me and netdev@oss.sgi.com
> 
> Ok
> 
>> 2) Consider using the bk-make-sum script (in Documentation/BK-usage/) 
>> to generate your summary.  This will add a "bk pull " prefix to your 
>> BK url particularly, making it even easier to cut-n-paste.
> 
> I do use bk-make-sum. A bit hacked version though which does not add
> 'bk pull' prefix. I'll put it back in if it's useful for folks.
> 
>> 3) Please include a patch in your submission so that list readers may 
>> review your changes, not just the BK users.
> 
> Anybody can go to bkbits.net and review them. I'd rather not send
> patches along with BK stuff, unless that's a new rule or something :).

It's not a new rule, it's an old rule :)  Changes need exposure and 
review _before_ they get merged and hit the kernel.  This is part of how 
Linux has always worked.

It's trivial to generate such a patch and include it in your email, 
using the gcapatch script in Documentation/BK-usage/

	Jeff


