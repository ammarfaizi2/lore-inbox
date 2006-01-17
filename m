Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWARFcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWARFcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWARFcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:32:53 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:63953 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S932130AbWARFcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:32:53 -0500
Message-ID: <43CD36FC.4020801@m1k.net>
Date: Tue, 17 Jan 2006 13:27:08 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
References: <43CCF8BB.1050009@m1k.net> <200601171739.17168.s0348365@sms.ed.ac.uk> <43CD309A.3030704@m1k.net> <200601171817.00182.s0348365@sms.ed.ac.uk>
In-Reply-To: <200601171817.00182.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Tuesday 17 January 2006 17:59, Michael Krufky wrote:
>[snip]
>  
>
>>>>... I have tried this at multiple locations, using several different
>>>>browsers under different OS's ... It won't show me a diff no matter what
>>>>I do, and it USED to work (about a week ago)
>>>>
>>>>I'm surprised nobody has complained about this already.  (or maybe I
>>>>just didnt see any such thread about it)
>>>>        
>>>>
>>>Seems to work for me right _now_, could you verify that this is still
>>>happening?
>>>      
>>>
>>I confirm, that nothing has changed...... Once again, no matter what OS, no matter what browser, no matter which location I am sitting at, I see no diff.
>>    
>>
>
>Try holding shift and pressing refresh. Maybe it's some bizarre caching issue?
>
>Also, try s/www/zeus2/ in the URL to see if it's a problem specific to one 
>server (I wonder if the reason some of us have problems and others don't is 
>that we are being http load balanced).
>
Well, when I used zeus2 directly, I can see the diff...... I tried doing 
the same with  zeus1, and in fact, the diff does not show.

That solves it!

Zeus2 is working correctly, Zeus1 isnt showing us any diff's ......

Thanks for the help, now, can this be fixed?

Cheers,

Michael Krufky


