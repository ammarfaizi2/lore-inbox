Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWBLTRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWBLTRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWBLTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:17:15 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:18408 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S1750873AbWBLTRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:17:14 -0500
Date: Sun, 12 Feb 2006 11:17:00 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: quick 3ware 8006-2LP question under 2.6 kernel
In-Reply-To: <Pine.LNX.4.64.0602120847470.19529@p34>
Message-ID: <Pine.LNX.4.64.0602121116070.5754@twin.uoregon.edu>
References: <Pine.LNX.4.64.0602120847470.19529@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the card is phyiscally compatible with a a 5volt 32bit pci slot then 
chances are it was designed to work at 32bit 33mhz...

joelja

On Sun, 12 Feb 2006, Justin Piszcz wrote:

> This card is (64bit PCI) and many people run these cards in 32 bit slots if 
> their motherboards do not have the 64bit PCI slots, is there any risk of 
> corruption or problems running it this way, or will it just run slower?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

