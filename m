Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUJRW0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUJRW0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUJRW0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:26:50 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:55753 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S267607AbUJRW0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:26:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: -final, a huge keyboard lag is back
Date: Mon, 18 Oct 2004 18:26:37 -0400
User-Agent: KMail/1.7
Cc: Jeff Garzik <jgarzik@pobox.com>
References: <200410181139.16083.gene.heskett@verizon.net> <41742128.3030305@pobox.com>
In-Reply-To: <41742128.3030305@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410181826.37524.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.58.180] at Mon, 18 Oct 2004 17:26:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 16:01, Jeff Garzik wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> for the last 3 or 4 minor revisions, and 3 different kde installs
>> I have had a situation wherein the keyboard repeat goes down to
>> less than 1 per second, making it very difficult to go back and
>> fix the typu's my ancient fingers inevitably make.  The effect
>> came and went at seemingly random times.
>
>Does this happen on console, or just in X?
>
Not so far as I've checked Jeff.  I normally run x here and the 
console is basicly for emergencies in my mindset.

>I am currently seeing:  fast keyboard repeat immediately after
> keypress, for one second.  After that, keyboard repeat slows
> immediately and dramatically, to a slower but consistent repeat
> rate.

I'm not seeing that, and its more than occasionally missing a keypress 
I know darned well I hit.   ATM its not doing it, but then I'm 
rebooted to -rc4 due to instability in final.  I've canceled an 
option I had set in the -finals .config, and a fresh copy is making 
now.  So we'll be able to go back to testing -final in a short.

>This doesn't happen in console.

I can't say as I've ever noticed it from the first 6 vt's.

> Jeff

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
