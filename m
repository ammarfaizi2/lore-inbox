Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTF1LGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 07:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTF1LGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 07:06:21 -0400
Received: from [62.248.102.66] ([62.248.102.66]:31681 "HELO
	eposta.kablonet.com.tr") by vger.kernel.org with SMTP
	id S265145AbTF1LGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 07:06:20 -0400
Message-ID: <3EFD7B14.7060307@kablonet.com.tr>
Date: Sat, 28 Jun 2003 14:25:08 +0300
From: Onur Kucuk <onur@kablonet.com.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030514
X-Accept-Language: en, en-us, tr
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-ac4 & cm9739 & SATA
References: <3EFCD206.2020501@kablonet.com.tr> <3EFCF119.7000809@pobox.com>
In-Reply-To: <3EFCF119.7000809@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Onur Kucuk wrote:
> 
>>    SATA (hde) is gone at 2.4.21-ac3 (and ac4), though system see it 
>> with 2.4.20
> 
> 
> 
>> # CONFIG_SCSI_ATA is not set
>> # CONFIG_SCSI_ATA_PIIX is not set
> 
> 
> 
> Though I didn't see it in his changelog, it looks like Alan merged my 
> SATA driver.  Turn on the above two config options, and that should 
> re-enable it.
> 
>     Jeff


  Done, working fine, thank you

  Now I have a shiny new sda instead of the old hde :)


  And just if I can find a way to make the sound work properly



  Regards,
  Onur Kucuk


