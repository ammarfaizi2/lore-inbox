Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVCOA1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVCOA1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVCOA1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:27:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:25063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262150AbVCOA0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:26:42 -0500
Message-ID: <42362BAD.90203@osdl.org>
Date: Mon, 14 Mar 2005 16:26:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
CC: dwmw2@infradead.org, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: use unsigned 1-bit fields
References: <20050314160701.494a50d8.rddunlap@osdl.org> <20050315001445.GB6903@home.fluff.org>
In-Reply-To: <20050315001445.GB6903@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On Mon, Mar 14, 2005 at 04:07:01PM -0800, Randy.Dunlap wrote:
> 
>>(resend)
>>
>>Fix (22) bitfield/boolean sparse warnings:
>>include/linux/mtd/flashchip.h:65:23: warning: dubious one-bit signed bitfield
>>include/linux/mtd/flashchip.h:66:23: warning: dubious one-bit signed bitfield
> 
> 
> caught in the mtd-cvs, so it depends if you want to
> wait for the next mtd merge or not.

That's fine by me.  I didn't know it had made it to the mtd-cvs.

Thanks for the message.

-- 
~Randy
