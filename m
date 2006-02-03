Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWBCSSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWBCSSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWBCSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:18:41 -0500
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72]:7372 "EHLO
	pop-sarus.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751311AbWBCSSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:18:40 -0500
Message-ID: <43E39E77.90403@earthlink.net>
Date: Fri, 03 Feb 2006 13:18:31 -0500
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Panagiotis Issaris <takis.issaris@uhasselt.be>,
       linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: Re: WLAN drivers
References: <1138969138.8434.26.camel@localhost.localdomain>	 <200602031235.31098.s0348365@sms.ed.ac.uk> <1138990013.15691.272.camel@mindpipe>
In-Reply-To: <1138990013.15691.272.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Fri, 2006-02-03 at 12:35 +0000, Alistair John Strachan wrote:
>  
>
>>In my experience, you're simply best going to either
>>http://prism54.org/ (if you can find one still) or http://madwifi.org/
>>(modern cards, likely to be purchasable), and then buying one of the
>>cards on the "known to work" lists. If you buy the wrong revision,
>>return it. 
>>    
>>
>
>Isn't madwifi a proprietary driver?  Are things really so bad that
>people on LKML are recommending users buy this junk?
>
>Lee
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
I'd been waiting for along time to get a wireless card for my Linux 
system at a reasonable price. A couple of weeks ago CompUSA had zyxel 
g102's fo 19.95 and  zyxel  base stations
for 19.95 - no rebates were involved:) So I got one of each. The pc-card 
uses an atheros chip
which is supported by MadWifi. The module includes a binary hal module 
that keeps the
card from being abused - programmed out of FCC specs. Why is so 
different from a card that
has to have firmware loaded on it that in essence does the same thing - 
prevents the driver
writer from programming the card out of FCC specs.

And Atheros stepped up to the table and provide this hal binary piece.

My $.02
Steve
