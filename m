Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUGNQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUGNQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUGNQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:34:27 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:53992 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S267452AbUGNQeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:34:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Mail System Error - Returned Mail
Date: Wed, 14 Jul 2004 12:34:09 -0400
User-Agent: KMail/1.6
References: <200407132306.39569.gene.heskett@verizon.net> <20040714082336.GM1486@mea-ext.zmailer.org>
In-Reply-To: <20040714082336.GM1486@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141234.09591.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [141.153.91.175] at Wed, 14 Jul 2004 11:34:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 July 2004 04:23, Matti Aarnio wrote:
>On Tue, Jul 13, 2004 at 11:06:39PM -0400, Gene Heskett wrote:
>> Greetings;
>>
>> I'm getting a lot of these bounces, any good reason?
>
>Dunno,  but we also see (every now and then) that Verizon
>system rejects emails towards it with MAIL FROM giving
>vger.kernel.org  domain.

Yeah, I'm getting unsubbed from some mailing lists because of 
excessive bounces.

>Reading deeper, the visible "To:" header, and "remote mta"
>line do say:   vgr.kernel.org   which isn't quite exactly right...

I think I found it, that miss-spelling was how it was here in kmails 
folder preferences when the "folder contains a mailing list" option 
is checked.  There I had the vgr as you see, instead of vger.

I'm pretty sure that fixes at least one glitch, and may explain why 
some of my messages have been ignored.  I may not have seen the 
bounce message because most of them are spam and are sorted to a 
folder thats autocleaned when I quite kmail.

But then I'm an old fart, and easliy ignored most of the time too :-)

[...]

>From the symptoms I do suspect that Verizon's DNS server(s) are
>malfunctioning somehow.

They are in fact, in plain english, a pain in the ass. Miss-configured 
pieces of M$ driven crap, occasionally viri infected even, up and 
down like a Duncan yoyo.  Here about a year ago, I had just setup a 
new Seimans dsl router.  It had been setup about 2 weeks, when one 
day it wasn't working again and I couldn't access its web page.  
There was just one line in my logs, giving their DNS's machines ip as 
the cuplrit, indicating it had been hacked and they had actually 
gotten thru to my firewall machine, but portsentry is set to be 
paranoid & shut them off on the first syn packet.  The router had 
been hacked, the password and apparently its ip address had been 
hacked, I couldn't find a button to restore factory defaults, so I 
said screw it, gave it back to Circuit City and brought home a 
linksys for twice the money.  It's been bulletproof so far.

>An alternate is that their MTA software is treating temporary DNS
>failures (like lookup timeout) as instantly permanent failures and
>as a valid reason for reject, which would be a mad thing to do.

Thats possible, I've run query's to it, had them fail, work 10x in a 
row, and fail twice in a row, all in the space of a minute or less.

[snip the rest]

Many thanks for looking into it, as usual, I was the little boy crying 
wolf. Since I'll be 70 shortly, thats not a pretty sight :-)

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
