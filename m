Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbSIZEWr>; Thu, 26 Sep 2002 00:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262171AbSIZEWr>; Thu, 26 Sep 2002 00:22:47 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:1501 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262170AbSIZEWq>; Thu, 26 Sep 2002 00:22:46 -0400
Message-ID: <3D928D46.3020706@snapgear.com>
Date: Thu, 26 Sep 2002 14:29:58 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Randy Dunlap <rddunlap@osdl.org>
CC: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>        <3D927278.6040205@snapgear.com> <1243.4.64.197.173.1033010387.squirrel@www.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy Dunlap wrote:
>>>* You're defining CONFIG_* variables in the .c file.  I don't know
>>>whether
>>>  this is something we're still trying to avoid doing ... Greg, you
>>>seem to be CodingStyle enforcer, what's the word?
>>
>>I missed this the first time through :-)
>>I am not sure what you mean, CodingStyle enforcer?
>>Can you elaborate for me?
> 
> 
> 
> Willy is talking about Greg Kroah-Hartman here, not you.

Oooh, ok, that makes sense then.

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

