Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVBGRO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVBGRO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVBGRO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:14:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:27270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261198AbVBGROT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:14:19 -0500
Message-ID: <42079D8E.7020909@osdl.org>
Date: Mon, 07 Feb 2005 08:55:42 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Lee Revell <rlrevell@joe-job.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Pavel Roskin <proski@gnu.org>, Joseph Pingenot <trelane@digitasaru.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: Please open sysfs symbols to proprietary modules
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>	 <20050203000917.GA12204@digitasaru.net>	 <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>	 <692795D1-758E-11D9-9D77-000393ACC76E@mac.com> <1107674683.3532.26.camel@krustophenia.net> <420791D7.3020408@nortel.com>
In-Reply-To: <420791D7.3020408@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Lee Revell wrote:
> 
>> On Wed, 2005-02-02 at 21:50 -0500, Kyle Moffett wrote:
>>
>>> It's not like somebody will have
>>> some innate commercial advantage over you because they have your
>>> driver source code.
>>
>>
>>
>> For a hardware vendor that's not a very compelling argument.  Especially
>> compared to what their IP lawyers are telling them.
>>
>> Got anything to back it up?
> 
> 
> I have a friend who works for a company that does reverse-engineering of 
> ICs.  Companies hire them to figure out how their competitor's chips 
> work.  This is the real threat to hardware manufacturers, not publishing 
> the chip specs.
> 
> Having driver code gives you the interface to the device.  That can be 
> reverse-engineered from watching bus traces or disassembling binary 
> drivers (which is how many linux drivers were originally written). 
> Companies have these kinds of resources.
> 
> If you look at the big chip manufacturers (TI, Maxim, Analog Devices, 
> etc.) they publish specs on everything.  It would be nice if others did 
> the same.

One of the arguments that I have heard is fairly old and debatable as
well.  This was the subject of a panel discussion at LWE in 2000 or
2001, chaired by journalist Nicholas Petreley.  The panel was composed
of vendors from (mostly) audio devices IIRC, but I'm not sure.

The bottom line summary was agreement that open-source drivers usually
expose how generation A of a device works, while the company is off
building generation B, and designing generation C.  So if another
company wants to clone generation A and be left in the dust when
their product is ready, let them.  They will usually lose.

-- 
~Randy
