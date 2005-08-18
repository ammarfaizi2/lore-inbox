Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVHRVF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVHRVF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVHRVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:05:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43225 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932443AbVHRVF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:05:28 -0400
Message-ID: <4304F80F.10302@pobox.com>
Date: Thu, 18 Aug 2005 17:05:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mateusz Berezecki <mateuszb@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Atheros and rt2x00 driver
References: <6278d22205081711115b404a9b@mail.gmail.com> <20050818205821.GA30510@localhost.localdomain>
In-Reply-To: <20050818205821.GA30510@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mateusz Berezecki wrote:
> Daniel J Blueman <daniel.blueman@gmail.com> wrote:
> -> 
> -> There is a good chance the rt2x00 driver will get into the kernel tree
> -> in time, since there is no firmware to upload - Ralink Tech
> -> (www.ralink.com.tw) took a design decision to incorporate the firmware
> -> into an EEPROM on-board, allowing their driver to be GPL'd, and the
> -> rt2x00 is a Linux-specific rewrite which is stabilising well.
>  
>   the same applies to atheros. they got stuff either in eeprom or in
>   driver. no firmware necessary. 
>   
>   there is an ongoing project for atheros cards.
>   work in progress located at http://mateusz.agrest.org/atheros/


There is still the open question of whether this is legal enough to 
include in the kernel :(

I really would have preferred a cleanroom approach, like that taken by 
the forcedeth driver authors.

	Jeff


