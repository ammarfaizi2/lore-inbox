Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSC3BxP>; Fri, 29 Mar 2002 20:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312356AbSC3BxG>; Fri, 29 Mar 2002 20:53:06 -0500
Received: from freeside.toyota.com ([63.87.74.7]:30728 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S312355AbSC3Bw7>; Fri, 29 Mar 2002 20:52:59 -0500
Message-ID: <3CA51A37.2020701@lexus.com>
Date: Fri, 29 Mar 2002 17:51:51 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020328
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: Kernel hosed or Nvidia modules?
In-Reply-To: <E16r842-0002Nb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To be fair, I've had far less trouble with
nvidia drivers than with some of the
open source dri ones -

But it's best if you can reproduce the bug
without the nvidia driver loaded, to remove
all doubt.

If 3D graphics support is needed on that
box, perhaps a  cheap voodoo3 would
get you going in the meantime.  :-)

Hopefully some nvidia folks lurk on the list,
in case it is somehow related...

Joe

Alan Cox wrote:

>>Is that a genuine kernel bug (2.4.19-pre2-ac3 here) or Yet Another
>>Nvidia Driver Bug (would not be the first bug to bite me in their
>>
>
>Only Nvidia can tell you that. Please don't bother this list with oopses
>when binary modules are loaded. Nobody can help you
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


