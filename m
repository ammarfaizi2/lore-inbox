Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVBGQHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVBGQHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVBGQHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:07:06 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:19168 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261170AbVBGQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:06:51 -0500
Message-ID: <420791D7.3020408@nortel.com>
Date: Mon, 07 Feb 2005 10:05:43 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Pavel Roskin <proski@gnu.org>,
       Joseph Pingenot <trelane@digitasaru.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: Please open sysfs symbols to proprietary modules
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>	 <20050203000917.GA12204@digitasaru.net>	 <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>	 <692795D1-758E-11D9-9D77-000393ACC76E@mac.com> <1107674683.3532.26.camel@krustophenia.net>
In-Reply-To: <1107674683.3532.26.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2005-02-02 at 21:50 -0500, Kyle Moffett wrote:
> 
>>It's not like somebody will have
>>some innate commercial advantage over you because they have your
>>driver source code.
> 
> 
> For a hardware vendor that's not a very compelling argument.  Especially
> compared to what their IP lawyers are telling them.
> 
> Got anything to back it up?

I have a friend who works for a company that does reverse-engineering of 
ICs.  Companies hire them to figure out how their competitor's chips 
work.  This is the real threat to hardware manufacturers, not publishing 
the chip specs.

Having driver code gives you the interface to the device.  That can be 
reverse-engineered from watching bus traces or disassembling binary 
drivers (which is how many linux drivers were originally written). 
Companies have these kinds of resources.

If you look at the big chip manufacturers (TI, Maxim, Analog Devices, 
etc.) they publish specs on everything.  It would be nice if others did 
the same.

Chris
