Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSGAQNK>; Mon, 1 Jul 2002 12:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGAQNJ>; Mon, 1 Jul 2002 12:13:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32527 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315762AbSGAQNG>;
	Mon, 1 Jul 2002 12:13:06 -0400
Message-ID: <3D20801A.3040606@mandrakesoft.com>
Date: Mon, 01 Jul 2002 12:15:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
CC: Samuel Thibault <samuel.thibault@fnac.net>, linux-sound@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 linux/drivers/maestro.c dev_audio flaw
References: <Pine.LNX.4.44.0206302335280.592-100000@localhost.localdomain> <20020701120740.J28390@erasmus.off.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
>>It seems that the value of ess->dev_audio is wrongly interpreted. 
> 
> 
> Thanks for attacking this driver, Samuel.  Your patches have looked good
> so far.  I'm sorry I'm not more involved; its been quite a while since
> I've futzed about with the maestro(s).



I'm afraid I missed the original patches :(

But I am willing to review and apply drivers/sound [sound/oss in 2.5] 
patches, if no one else (Alan?) does so.

Regards,

	Jeff



