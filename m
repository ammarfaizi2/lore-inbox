Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422976AbWCXCeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422976AbWCXCeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWCXCeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:34:13 -0500
Received: from bay0-omc1-s34.bay0.hotmail.com ([65.54.246.106]:24285 "EHLO
	bay0-omc1-s34.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932637AbWCXCeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:34:12 -0500
Message-ID: <BAY109-DAV187923EE24B95ED9F5B94B3DF0@phx.gbl>
X-Originating-IP: [72.60.172.10]
X-Originating-Email: [zhaojingmin@hotmail.com]
From: "Jing Min Zhao" <zhaojingmin@hotmail.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Jing Min Zhao" <zhaojignmin@hotmail.com>
Cc: <netdev@vger.kernel.org>, <netfilter-devel@lists.netfilter.org>,
       <linux-kernel@vger.kernel.org>
References: <20060324001307.GO22727@stusta.de>
Subject: Re: Two comments on the H.323 conntrack/NAT helper
Date: Thu, 23 Mar 2006 21:34:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 24 Mar 2006 02:34:11.0174 (UTC) FILETIME=[6EE9E060:01C64EEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Adrian Bunk" <bunk@stusta.de>
To: "Jing Min Zhao" <zhaojignmin@hotmail.com>
Cc: <netdev@vger.kernel.org>; <netfilter-devel@lists.netfilter.org>; 
<linux-kernel@vger.kernel.org>
Sent: Thursday, March 23, 2006 7:13 PM
Subject: Two comments on the H.323 conntrack/NAT helper


> Two comments on the H.323 conntrack/NAT helper:
Thank you for your advice.

> - the function prototypes in ip_nat_helper_h323.c are _ugly_,
>  please move them to a header file
Correct, I'll do that.

> - is there a reason for not using EXPORT_SYMBOL_GPL?
>
No, I just forgot it. I'll change this too.

> cu
Hope I can get more advice from you.

> Adrian
>
> -- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
That's Hepburn :-)

>
>
