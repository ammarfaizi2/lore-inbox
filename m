Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130681AbRCLW1g>; Mon, 12 Mar 2001 17:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRCLW10>; Mon, 12 Mar 2001 17:27:26 -0500
Received: from smtp.hattaway-associates.com ([203.79.82.65]:35536 "EHLO
	server01.hattaway-associates.com") by vger.kernel.org with ESMTP
	id <S130681AbRCLW1J>; Mon, 12 Mar 2001 17:27:09 -0500
Message-ID: <3AAD4D11.E6C542A7@hattaway-associates.com>
Date: Tue, 13 Mar 2001 11:26:25 +1300
From: Godfrey Livingstone <godfrey@hattaway-associates.com>
Reply-To: godfrey@hattaway-associates.com
Organization: Hattaway and Associates
X-Mailer: Mozilla 4.76 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Chip Rodden <chip_rodden@hotmail.com>
CC: jbrosnan@asitatech.ie, tulip@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [tulip] Linux 2.2.16/Tulip Smartbits testing.
In-Reply-To: <F88SMmGB7Wz4e9StHov000115fc@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Are you going to make your driver available for others to use?


Godfrey

Chip Rodden wrote:

> John,
>
> It's the driver.  We have been doing smartbits testing for more
> than a year and found the same results as you appear to be getting.
> The driver just dies and never recovers.  It attempts to do
> interrupt mitigation(coalescing) but that appears to be useless.
>
> The solution is to write a new driver which is what we have done
> here...
>
> Chip
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

