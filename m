Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFDNhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFDNhp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 09:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFDNhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 09:37:45 -0400
Received: from mail.tmr.com ([64.65.253.246]:10378 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261342AbVFDNhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 09:37:35 -0400
Message-ID: <42A1AE8B.5000907@tmr.com>
Date: Sat, 04 Jun 2005 09:37:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Helge Hafting <helge.hafting@aitel.hist.no>,
       Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com> <429EC91A.7020704@aitel.hist.no> <429EF4E2.2050907@tmr.com> <20050602133357.GN23621@csclub.uwaterloo.ca>
In-Reply-To: <20050602133357.GN23621@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>On Thu, Jun 02, 2005 at 08:00:34AM -0400, Bill Davidsen wrote:
>  
>
>>Unfortunately even drives in a dual power tray with redundany power from 
>>separate UPS sources will occasionally have a power failure. Proved that 
>>last month, the power strip in the rack failed, dumped all the load on 
>>the other leg, the surge tripped a breaker. Had an APC UPS in my office 
>>fail in a mode which dropped power, waited for the battery to trickle 
>>charge to charge the battery a bit, then repeat. Looks to be losing half 
>>of a full wave rectifier.
>>
>>The point is that power failures WILL HAPPEN, even with good backups. 
>>The goal should be to prevent excessive and avoidable data damage when 
>>it does.
>>
>>Shameless plug: for office use I changed from APC to Belkin on all new 
>>units, they have had Linux drivers for some time now, and I like to 
>>support those who support Linux.
>>    
>>
>
>Hasn't apcupsd existed for at least a decade?  Works rather well for me.
>Hard to imagine better linux/unix support than APC seems to have
>provided so far.
>  
>

I thought apcuspd was a third party project, sourceforce shows it as a 
project. Didn't know APC was actually "providing" anything, is the 
driver on the CD now? Sure wasn't on the APC CD I had, I did have it at 
one time, but it didn't come with the UPS (at that time).

>For some reason Belkin screms cheap junk to me.  Maybe that's because
>that is what you always see for sale with that brand on it.  They may
>have nice stuff that I just haven't seen because it isn't carried by
>most stores.
>
You don't have Staples or Wal-Mart? Office Max did drop the UPS, the 
local store manager said the issue was margin, hadn't had enough returns 
on either brand to be meaningful.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

