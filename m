Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbTCRCnR>; Mon, 17 Mar 2003 21:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbTCRCnR>; Mon, 17 Mar 2003 21:43:17 -0500
Received: from ip-92-118-134-202.rev.dyxnet.com ([202.134.118.92]:46901 "EHLO
	mail.office") by vger.kernel.org with ESMTP id <S262103AbTCRCnQ>;
	Mon, 17 Mar 2003 21:43:16 -0500
Message-ID: <3E768B87.6080605@thizgroup.com>
Date: Tue, 18 Mar 2003 10:59:19 +0800
From: =?UTF-8?B?QWxleCBMYXUg5YqJ5L+K6LOi?= <alexlau@thizgroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: zh-hk, zh-tw, zh-cn
MIME-Version: 1.0
To: "\"Juergen \"George\" \"Sawinski" <george@mpimf-heidelberg.mpg.de>
CC: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: Does SX6000 work?
References: <3E753141.8050807@thizgroup.com> <1047867950.28267.4.camel@volans>
In-Reply-To: <1047867950.28267.4.camel@volans>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen "George" Sawinski wrote:

>Follow the thread:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=104431067011756&w=2
>
>George
>  
>
I finally get the SX6000 working but I'm not using the I2O. The promise 
driver
seem to work better. But I do get I2O to mount the driver only the fact 
that it
keep giving me

i2o/iop0: No handler for event (0x00000020)

i2o/iop0: Hardware Failure: Unknown Error

 From here Alan talk about some solution that may make it work... But I 
don't
really understand it.
http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.3/0374.html

Anyway, I try 2.4.18 ( it hang on boot ), 2.4.19 ( it hang on boot),
2.4.20 ( it work with lot of message ) i2o and still not working. So I 
use the
promise driver right now. If anyone know what should I do to get I2O work
with SX6000, please let me know. I would like to compare the drivers.
Thanks
Alex




