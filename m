Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJYVXf>; Thu, 25 Oct 2001 17:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276380AbRJYVXZ>; Thu, 25 Oct 2001 17:23:25 -0400
Received: from mail.inconnect.com ([209.140.64.7]:43920 "HELO
	mail.slc.sw.incc.net") by vger.kernel.org with SMTP
	id <S276369AbRJYVXG>; Thu, 25 Oct 2001 17:23:06 -0400
Message-ID: <3BD883DD.8050506@prospectplanet.com>
Date: Thu, 25 Oct 2001 15:27:57 -0600
From: Charles Johnston <charles@prospectplanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, pt-br
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: hgafb broken in 2.4.13
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was working fine in 2.4.12 for me.
When I booted 2.4.13 on the same machine with identical config it
panicked on boot and had garbage on that screen.

BTW, where can I find out exactly what order all the drivers get
loaded?  I wanted to track the panic down earlier.


Charles

On 2001.10.25 07:57 Pavel Machek wrote:
 > Hi!
 >
 > In some time between 2.4.9 and 2.4.13, hgafb broke... Now it displays
 > trash during boot (damaged screen from previous boot), and system
 > freezes.
 >                                                               Pavel
 > --
 > STOP THE WAR! Someone killed innocent Americans. That does not give
 > U.S. right to kill people in Afganistan.
 >
 >
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
 > in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 >


