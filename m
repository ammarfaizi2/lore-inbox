Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292783AbSCIOkI>; Sat, 9 Mar 2002 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292784AbSCIOj6>; Sat, 9 Mar 2002 09:39:58 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:30632 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S292783AbSCIOj4>; Sat, 9 Mar 2002 09:39:56 -0500
Message-ID: <3C8A1E35.7030602@wanadoo.fr>
Date: Sat, 09 Mar 2002 15:37:41 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6-pre3 boot hangs in ide probing
In-Reply-To: <3C89C3D4.3070004@wanadoo.fr> <3C8A09BD.7080103@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Pierre Rousselet wrote:
> 
>> The motherboard is abit BE6 (4 ide, piix and hpt366) with a pIII 
>> coppermine.
>> For reference below is dmesg with a booting 2.5.6-pre2.
>>
> 
> I observed the same on pre3. But the bug is not ide related,
> since the plain ide patches applied on top of pre2 just worked.
> 
> (I happen to own the same hpt366 card as you.)

Thanks. 2.5.6 actually boots cleanly.

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

