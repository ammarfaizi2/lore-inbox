Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317780AbSFSFvO>; Wed, 19 Jun 2002 01:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317781AbSFSFvN>; Wed, 19 Jun 2002 01:51:13 -0400
Received: from handhelds.org ([192.58.209.91]:2780 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S317780AbSFSFvL>;
	Wed, 19 Jun 2002 01:51:11 -0400
From: George France <france@handhelds.org>
To: Richard Liu <richliu@ite.techarea.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Does it have SD/MMC Driver?
Date: Wed, 19 Jun 2002 01:50:44 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
References: <20020619105928.CD87.RICHLIU@ite.techarea.org>
In-Reply-To: <20020619105928.CD87.RICHLIU@ite.techarea.org>
MIME-Version: 1.0
Message-Id: <02061901504400.06509@shadowfax.middleearth>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

There is a MMC driver from the kernel cvs tree at handhelds.org.  It was just 
announced today.  Please see:

http://handhelds.org/pipermail/ipaq/2002-June/014310.html

As for SD, I do not believe that it is legally possible to have an Open 
Source SD driver.  It may be possible to have a bin only Closed Source SD 
driver.  It is probably best that you check with a legal professional.

Best Regards,


--George

On Tuesday 18 June 2002 23:04, Richard Liu wrote:
> Hi.
>     does anyone porting SD/MMC driver in linux platform?
> I want to porting SD/MMC driver,
>
> It's a chip which using LPC connect to south bridge.
> I want some information about how to porting it,
> like major/minor number, etc.
>
> If anyone have information about this, could you give me a head?
> --
> Richard Liu, an Linux Device driver developer .
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
