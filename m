Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271631AbRHUKLJ>; Tue, 21 Aug 2001 06:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271630AbRHUKK7>; Tue, 21 Aug 2001 06:10:59 -0400
Received: from web20102.mail.yahoo.com ([216.136.226.39]:1548 "HELO
	web20102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271631AbRHUKKt>; Tue, 21 Aug 2001 06:10:49 -0400
Message-ID: <20010821101104.96000.qmail@web20102.mail.yahoo.com>
Date: Tue, 21 Aug 2001 03:11:04 -0700 (PDT)
From: Venu Gopal Krishna Vemula <vvgkrishna_78@yahoo.com>
Subject: Re: On Network Drivers......
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E15YoId-0005y8-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sir,

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>>  A driver of layered one.., in which one layer
>> communicates with another. But overall there 
>> should be  only one driver . (Just like Stream's
>> drivers, but we don't want Stream Drivers). 

> 
> We have a single layer between the network stack and
> the drivers. However  nothing stops drivers from 
> implementing multiple  layers internally or
> calling back into other drivers. shaper is an
> example of a driver that  calls other drivers.
> 

 Can you please explain something about implementing
multiple layers internally in a Network Driver 
                     or
 inform me where i can find information (Source code)

         Today i have searched a lot to find any
information related to the Network driver(in which
multiple layers has to develop internally)  in
Internet, but i could not found any source code or
information in Internet.

With Thanks,
regards,
vvgkrishna_78@yahoo.com


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
