Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUCKSOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUCKSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:14:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:25244 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261627AbUCKSOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:14:53 -0500
X-Authenticated: #4512188
Message-ID: <4050AC9B.80706@gmx.de>
Date: Thu, 11 Mar 2004 19:14:51 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: ACPI PM Timer vs. C1 halt issue
References: <404E38B7.5080008@gmx.de>	 <1078870289.12084.8.camel@cog.beaverton.ibm.com>  <404E4913.3020005@gmx.de>	 <1078955372.2696.23.camel@cog.beaverton.ibm.com> <1078956711.2557.72.camel@dhcppc4>
In-Reply-To: <1078956711.2557.72.camel@dhcppc4>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grrr,

this is driving me nuts. Now with the same kernel/config I used 
yesterday I again have 51°C of idle temp after 2h of uptime. Yesterday I 
had 12h of uptime and at the end temp was at 39°C. I slowly begin to 
think that the sensors show something wrong? At least I can't explain 
the difference. Yesterday after going back to tsc timer, temp 
immedeatley started dropping after booting up that kernel. I will now 
compile 2.6.3 again and see whether temp starts dropping after boot.

I am really starting to get frustrated...

Prakash
