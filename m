Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTABHSN>; Thu, 2 Jan 2003 02:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTABHSN>; Thu, 2 Jan 2003 02:18:13 -0500
Received: from d40.sstar.com ([209.205.179.40]:34558 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id <S266161AbTABHSN>;
	Thu, 2 Jan 2003 02:18:13 -0500
Message-ID: <3E13E9B0.8050504@asjohnson.com>
Date: Thu, 02 Jan 2003 01:26:40 -0600
From: "Andrew S. Johnson" <andy@asjohnson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] So sloowwwww......
References: <fa.el8u04v.1jks783@ifi.uio.no> <fa.f29f77v.on2i97@ifi.uio.no>
In-Reply-To: <fa.f29f77v.on2i97@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:
> Well, I did made another kernel without ACPI and with APM, 
> and it is working fine.

Did you try using acpi=no-idle in your kernel append line (if using
lilo) and see what difference that makes?  It works in 2.4.

Andy Johnson

> 
> To summarize :
>  - ACPI Enumeration only is fine
>  - More functionnalities from ACPI is bad.
> 
> If someone has an idea and wants me to make tests, please contact
> me...
> 
> Regards,
> Paul

