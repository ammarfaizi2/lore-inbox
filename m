Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbULAJdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbULAJdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 04:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULAJdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 04:33:12 -0500
Received: from mail.mev.co.uk ([62.49.15.74]:42460 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S261350AbULAJc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 04:32:56 -0500
Message-ID: <41AD8FC7.3050308@mev.co.uk>
Date: Wed, 01 Dec 2004 09:32:55 +0000
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] serial closing_wait and close_delay
References: <41ACC49A.20807@mev.co.uk> <1101841028.25628.109.camel@localhost.localdomain>
In-Reply-To: <1101841028.25628.109.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2004 09:32:50.0269 (UTC) FILETIME=[B99B18D0:01C4D788]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2004 18:57, Alan Cox wrote:
> On Maw, 2004-11-30 at 19:06, Ian Abbott wrote:
> 
>>Dear Marcelo,
>>
>>This patch should fix various problems with the closing_wait and 
>>close_delay serial parameters, but I can only test the standard serial 
>>driver.
> 
> 
> Thanks - I've added that to my 2.6.x serial todo pile if nobody else
> does it first.

I've already submitted a patch to the linux-serial list, but only 
for the serial_core driver.  (Apologies to Russell King and the 
linux-serial subscribers for submitting it twice!)

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
