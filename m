Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTJETVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbTJETVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:21:25 -0400
Received: from h1ab.lcom.net ([216.51.237.171]:1152 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S263782AbTJETVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:21:23 -0400
Date: Sun, 5 Oct 2003 14:21:19 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Scott West <swest3@cogeco.ca>, linux-kernel@vger.kernel.org
Subject: Re: cs4281 driver missing from 2.6.0-test6-bk6?
Message-ID: <20031005192117.GA3445@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Muli Ben-Yehuda <mulix@mulix.org>,
	Scott West <swest3@cogeco.ca>, linux-kernel@vger.kernel.org
References: <20031005012438.GG4274@digitasaru.net> <20031004224102.64ff35c6.swest3@cogeco.ca> <20031005031754.GA8483@digitasaru.net> <20031005073613.GB29140@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005073613.GB29140@actcom.co.il>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Muli Ben-Yehuda on Sunday, 05 October, 2003:
>On Sat, Oct 04, 2003 at 10:17:55PM -0500, Joseph Pingenot wrote:
>> Aaaah.  Close.  It was "Gameport Support" that dunnit.  This laptop doesn't
>>   have such on it, so I thought I'd give it a whirl sans, especially since
>>   I'm trying to figure out why stuff is locking up on it.
>> Seems like an odd dependency.  You know why that is set up so?
>You can look in the archives for the exact details
>(http://marc.theaimsgroup.com/?l=linux-kernel&m=106479206731633&w=2),
>but the bottom line is that it's a bug and already fixed in Alsa CVS
>(equivalent patch also attached). Now we just need to wait until Linus
>pulls it in... 

Ah.  Makes sense.  Is just a curious minor annoyance.  Unfortunately,
  the major annoyances I find with 2.6.0-test6-bk6 are about to be posted.
  :)

Thanks!

-Joseph


-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
