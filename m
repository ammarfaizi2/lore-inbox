Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbUAHUak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUAHUak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:30:40 -0500
Received: from ns.clanhk.org ([69.93.101.154]:41089 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265690AbUAHUai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:30:38 -0500
Message-ID: <3FFD684C.7060207@clanhk.org>
Date: Thu, 08 Jan 2004 14:25:16 +0000
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What driver for NetXtreme?
References: <3FFDB0EC.90504@wanadoo.es>
In-Reply-To: <3FFDB0EC.90504@wanadoo.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xose Vazquez Perez wrote:

>Robert L. Harris wrote:
>
>  
>
>>I just ordered an eval of a IBM server.  This server is supposed to
>>have a Dual-Port NetXtreme Gigabit network card.  Anyone have any idea
>>what drivers I'm going to need for this sucker?
>>    
>>
>
>it's a broadcom NIC. The driver is tg3
>  
>

I use Broadcom's driver for my bcm5702: 
http://www.broadcom.com/drivers/downloaddrivers.php

They work great and enable all the hardware offload features.  I used 
version 2.2.34 on a server that had a 300 day uptime and it performed 
flawlessly; perfectly stable and FAST.

-ryan

