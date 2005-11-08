Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVKHWdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVKHWdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVKHWdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:33:44 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:16040 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030271AbVKHWdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:33:43 -0500
Message-ID: <43712830.90805@tmr.com>
Date: Tue, 08 Nov 2005 17:35:28 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Highpoint IDE types
References: <1131471483.25192.76.camel@localhost.localdomain>	 <pan.2005.11.08.19.02.09.190896@sci.fi> <1131480140.25192.98.camel@localhost.localdomain>
In-Reply-To: <1131480140.25192.98.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-11-08 at 21:02 +0200, Ville Syrjälä wrote:
> 
>>> *      HPT372                  4 (HPT366)      5     
>>> *      HPT372N                 4 (HPT366)      6     
>>> *      HPT372                  5 (HPT372)      0
>>
>>          ^^^^^^
>>
>>This one is called HPT372A by Highpoint's BIOS/Win drivers.
>>
>>Also I'm not sure if it's relevant but PCI ID 5 chips use a different
>>BIOS image than PCI ID 4 chips.
> 
> 
> I suspect it is relevant because the "372A" appears to have a different
> base clock to the HPT372.
> 
> Added to the list.
> 
May we assume that this information was gathered in the interest of 
something beyond pedantic curiousity? Will this simplify the driver 
code, improve performance or reliability, etc?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
